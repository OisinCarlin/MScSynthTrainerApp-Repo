//
//  ContentView.swift
//  testFilter
//
//  App initator calls the structure method
//
//  Keyboard toggle added, Play button also sets waveform in this code at the minute.
//
//  Created by Oisin Carlin on 04/07/2022.
//

import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import SwiftUI
import AudioToolbox
import AVFoundation
import AudioKitEX
import CAudioKitEX

struct OscillatorData {
    var isPlaying: Bool = false
    var frequency: AUValue = 440
    var amplitude: AUValue = 0.1
    var rampDuration: AUValue = 1
    
    var showKeyboard = false
}

class OscillatorConductor: ObservableObject, KeyboardDelegate {
    
    let engine = AudioEngine()
    
    func noteOn(note: MIDINoteNumber) {
        data.isPlaying = true
        data.frequency = note.midiNoteToFrequency()
    }
    
    func noteOff(note: MIDINoteNumber) {
        data.isPlaying = false
    }
    
    @Published var data = OscillatorData() {
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

struct OscillatorView: View {
    @StateObject var conductor = OscillatorConductor()
    
    var body: some View {
        VStack {
            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
                self.conductor.data.isPlaying.toggle()
                
                
                self.conductor.osc.setWaveform(Table(.square))
            }
//                        HStack {
//                            Spacer()
//                            Text("Sine").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.sine))
//                            }
//                            Spacer()
//                            Text("Square").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.square))
//                            }
//                            Spacer()
//                            Text("Triangle").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.triangle))
//                            }
//                            Spacer()
//                            Text("Sawtooth").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.sawtooth))
//                            }
//                            Spacer()
//                        }
            
            if(self.conductor.data.showKeyboard == false){
                ParameterSlider(text: "Frequency",
                                parameter: self.$conductor.data.frequency,
                                range: 220...880).padding()
            }
            
            ParameterSlider(text: "Amplitude",
                            parameter: self.$conductor.data.amplitude,
                            range: 0 ... 1).padding()
            //            ParameterSlider(text: "Ramp Duration",
            //                            parameter: self.$conductor.data.rampDuration,
            //                            range: 0...10).padding()
            
            //Show Keyboard button
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
                
            }
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                KeyboardControl(firstOctave: 0,
                                octaveCount: 2,
                                polyphonicMode: false,
                                delegate: conductor)
            }
        }.cookbookNavBarTitle("Oscillator")
            .onAppear {
                self.conductor.start()
            }
            .onDisappear {
                self.conductor.stop()
            }
    }
}

struct OscillatorView_Previews: PreviewProvider {
    static var previews: some View {
        OscillatorView()
    }
}

