//
//  BasicControlsViews.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 10/08/2022.
//

// **************** Oscillator Data *****************************

import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import SwiftUI
import AudioToolbox

struct BasicControlsOscillatorData {
    var isPlaying: Bool = false
    var frequency: AUValue = 440
    var amplitude: AUValue = 0.1
    var rampDuration: AUValue = 0.01
}

class BasicControlsOscillatorConductor: ObservableObject, KeyboardDelegate {
    
    let engine = AudioEngine()
    
    func noteOn(note: MIDINoteNumber) {
        data.isPlaying = true
        data.frequency = note.midiNoteToFrequency()
    }
    
    func noteOff(note: MIDINoteNumber) {
        data.isPlaying = false
    }
    
    @Published var data = BasicControlsOscillatorData() {
        didSet {
            if data.isPlaying {
                osc.start()
                osc.$frequency.ramp(to: data.frequency, duration: data.rampDuration)
                osc.$amplitude.ramp(to: data.amplitude, duration: data.rampDuration)
            } else {
                osc.amplitude = 0.0
            }
        }
    }
    
    var osc = Oscillator()
    
    init() {
        engine.output = osc
    }
    
    func start() {
        osc.amplitude = 0.2
        do {
            try engine.start()
        } catch let err {
            Log(err)
        }
    }
    
    func stop() {
        data.isPlaying = false
        osc.stop()
        engine.stop()
    }
}

struct BasicControlsAmplitudeOscillatorView: View {
    @StateObject var conductor = BasicControlsOscillatorConductor()
    
    var body: some View {
        VStack {
            
            
            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
                .padding()
                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
            
            HStack{
                ParameterSlider(text: "Amplitude",
                                parameter: self.$conductor.data.amplitude,
                                range: 0 ... 1).padding()
                VStack{
                    Text(" /1   ")
                    Text(" ")
                    Text(" ")
                }
            }
            
            NodeOutputView(conductor.osc)
            
        }.cookbookNavBarTitle("Play with Amplitude")
        
            .onAppear {
                self.conductor.start()
                
                // Do on show/hide keyboard also
                self.conductor.osc.setWaveform(Table(.sine))
            }
            .onDisappear {
                self.conductor.stop()
            }
    }
}

struct BasicControlsPitchOscillatorView: View {
    @StateObject var conductor = BasicControlsOscillatorConductor()
    
    var body: some View {
        VStack {
            
            
            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
                .padding()
                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
            
            HStack{
                ParameterSlider(text: "Frequency",
                                parameter: self.$conductor.data.frequency,
                                range: 20...880).padding()
                VStack{
                    Text("Hz ")
                    Text(" ")
                    Text(" ")
                }
                
            }
            
            NodeOutputView(conductor.osc)
            
        }.cookbookNavBarTitle("Play with Pitch")
            .onAppear {
                self.conductor.start()
                
                // Do on show/hide keyboard also
                self.conductor.osc.setWaveform(Table(.sine))
            }
            .onDisappear {
                self.conductor.stop()
            }
    }
}

struct BasicControlsKeyboardOscillatorView: View {
    @StateObject var conductor = BasicControlsOscillatorConductor()
    
    var body: some View {
        
        VStack {
//            ParameterSlider(text: "Amplitude",
//                            parameter: self.$conductor.data.amplitude,
//                            range: 0 ... 1).padding()
            NodeOutputView(conductor.osc)
            KeyboardControl(firstOctave: 3,
                            octaveCount: 1,
                            polyphonicMode: false,
                            delegate: conductor)
            
        }.cookbookNavBarTitle("Play using the Keyboard")
            .onAppear {
                self.conductor.start()
                
                // Do on show/hide keyboard also
                self.conductor.osc.setWaveform(Table(.sine))
            }
            .onDisappear {
                self.conductor.stop()
            }
    }
}

struct BasicControlsGlideOscillatorView: View {
    @StateObject var conductor = BasicControlsOscillatorConductor()
    
    var body: some View {
        VStack {
            
//            ParameterSlider(text: "Amplitude",
//                            parameter: self.$conductor.data.amplitude,
//                            range: 0 ... 1).padding()
            
            HStack{
            ParameterSlider(text: "Glide Time",
                            parameter: self.$conductor.data.rampDuration,
                            range: 0...10).padding()
                VStack{
                    Text("secs ")
                    Text(" ")
                    Text(" ")
                }
            }
            
            NodeOutputView(conductor.osc)
            KeyboardControl(firstOctave: 3,
                            octaveCount: 1,
                            polyphonicMode: false,
                            delegate: conductor)
            
        }.cookbookNavBarTitle("Play with Glide")
            .onAppear {
                self.conductor.start()
                // Do on show/hide keyboard also
                self.conductor.osc.setWaveform(Table(.sine))
            }
            .onDisappear {
                self.conductor.stop()
            }
    }
}
