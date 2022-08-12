//
//  HighPassFilter.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 05/08/2022.
//


import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import SwiftUI
import AudioToolbox
import AVFoundation
import AudioKitEX
import CAudioKitEX



struct HPFOscillatorData {
    var isPlaying: Bool = false
    var frequency: AUValue = 440
    var amplitude: AUValue = 0.1
    var rampDuration: AUValue = 0.1
    
    var showKeyboard = false
    
    var cutoffFrequency: AUValue = 1_000
    var resonance: AUValue = 0
    var balance: AUValue = 1
}

class HPFOscillatorConductor: ObservableObject, KeyboardDelegate {
    var osc = Oscillator()
    
    let engine = AudioEngine()
    let filter: HighPassFilter
    let dryWetMixer: DryWetMixer
    
    
    func noteOn(note: MIDINoteNumber) {
        data.isPlaying = true
        data.frequency = note.midiNoteToFrequency()
    }
    
    func noteOff(note: MIDINoteNumber) {
        data.isPlaying = false
    }
    
    @Published var data = HPFOscillatorData() {
        didSet {
            filter.cutoffFrequency = data.cutoffFrequency
            filter.resonance = data.resonance
            dryWetMixer.balance = data.balance
            
            
            if data.isPlaying {
                osc.start()
                osc.$frequency.ramp(to: data.frequency, duration: data.rampDuration)
                osc.$amplitude.ramp(to: data.amplitude, duration: data.rampDuration)
            } else {
                osc.amplitude = 0.0
            }
        }
    }
    
    init() {
        filter = HighPassFilter(osc)
        dryWetMixer = DryWetMixer(osc, filter)
        engine.output = dryWetMixer
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



struct HighPassFilterView: View {
    @StateObject var conductor = HPFOscillatorConductor()
    
    @State private var didTapSine:Bool = false
    @State private var didTapSquare:Bool = false
    @State private var didTapTriangle:Bool = false
    @State private var didTapSawtooth:Bool = false
    
    var body: some View {
        //                ScrollView {
        VStack {
            
            // Play button
            //            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
            //                self.conductor.data.isPlaying.toggle()
            //            }.foregroundColor(.green).font(Font.body.bold())
            
            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
                .padding()
                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
            
            // Waveform selector buttons
            HStack {
                Spacer()
                Text("Sine").onTapGesture {
                    self.conductor.osc.setWaveform(Table(.sine))
                    
                    self.didTapSine = true
                    self.didTapSquare = false
                    self.didTapTriangle = false
                    self.didTapSawtooth = false
                }
                .foregroundColor(didTapSine ? Color.red : Color.black).font(Font.body.bold())
                Spacer()
                
                Text("Square").onTapGesture {
                    self.conductor.osc.setWaveform(Table(.square))
                    
                    self.didTapSine = false
                    self.didTapSquare = true
                    self.didTapTriangle = false
                    self.didTapSawtooth = false
                }
                .foregroundColor(didTapSquare ? Color.red : Color.black).font(Font.body.bold())
                Spacer()
                
                Text("Triangle").onTapGesture {
                    self.conductor.osc.setWaveform(Table(.triangle))
                    
                    self.didTapSine = false
                    self.didTapSquare = false
                    self.didTapTriangle = true
                    self.didTapSawtooth = false
                }                .foregroundColor(didTapTriangle ? Color.red : Color.black).font(Font.body.bold())
                Spacer()
                
                Text("Sawtooth").onTapGesture {
                    self.conductor.osc.setWaveform(Table(.sawtooth))
                    
                    self.didTapSine = false
                    self.didTapSquare = false
                    self.didTapTriangle = false
                    self.didTapSawtooth = true
                }                .foregroundColor(didTapSawtooth ? Color.red : Color.black).font(Font.body.bold())
                Spacer()
            }
            if(self.conductor.data.showKeyboard == false){
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
                //                        .padding()
            }
            
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

            
//             NodeOutputView(conductor.osc)
            
            //Show Keyboard button
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
            }.foregroundColor(.orange).font(Font.body.bold())
            
            if(self.conductor.data.showKeyboard){
                KeyboardControl(firstOctave: 3,
                                octaveCount: 1,
                                polyphonicMode: false,
                                delegate: conductor)
            }
            
            
            Text("High Pass Filter Controls:").foregroundColor(.pink).font(Font.body.bold()).padding()
            ParameterSlider(text: "Cutoff Frequency",
                            parameter: self.$conductor.data.cutoffFrequency,
                            range: 12.0...3_000.0,
                            units: "Hertz")
            ParameterSlider(text: "Resonance",
                            parameter: self.$conductor.data.resonance,
                            range: -20...40,
                            units: "dB")
            ParameterSlider(text: "Filter Mix",
                            parameter: self.$conductor.data.balance,
                            range: 0...1,
                            units: "%")
            
            
        }
        
        DryWetMixView(dry: conductor.osc, wet: conductor.filter, mix: conductor.dryWetMixer)
        
        
            .cookbookNavBarTitle("High Pass Filter")
            .onAppear {
                self.conductor.start()
                
                self.conductor.osc.setWaveform(Table(.sine))
                
                self.didTapSine = true
                self.didTapSquare = false
                self.didTapTriangle = false
                self.didTapSawtooth = false
            }
            .onDisappear {
                self.conductor.stop()
            }
        
    }
    
}


struct HighPassFilter_Previews: PreviewProvider {
    static var previews: some View {
        HighPassFilterView()
    }
}






