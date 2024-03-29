//
//  BandPassFilter.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 05/08/2022.
//
// Band Pass Filter Example View
//

import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import SwiftUI
import AudioToolbox
import AVFoundation
import AudioKitEX
import CAudioKitEX



struct BPFOscillatorData {
    var isPlaying: Bool = false
    var frequency: AUValue = 440
    var amplitude: AUValue = 0.1
    var rampDuration: AUValue = 0.1
    
    var showKeyboard = false
    
    var centerFrequency: AUValue = 2_000.0
    var bandwidth: AUValue = 100.0
    //    var rampDuration: AUValue = 0.02
    var balance: AUValue = 1
}

class BPFOscillatorConductor: ObservableObject, KeyboardDelegate {
    var osc = Oscillator()
    
    let engine = AudioEngine()
    let filter: BandPassButterworthFilter
    let dryWetMixer: DryWetMixer
    
    
    func noteOn(note: MIDINoteNumber) {
        data.isPlaying = true
        data.frequency = note.midiNoteToFrequency()
    }
    
    func noteOff(note: MIDINoteNumber) {
        data.isPlaying = false
    }
    
    @Published var data = BPFOscillatorData() {
        didSet {
            filter.$centerFrequency.ramp(to: data.centerFrequency, duration: data.rampDuration)
            filter.$bandwidth.ramp(to: data.bandwidth, duration: data.rampDuration)
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
        filter = BandPassButterworthFilter(osc)
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



struct BandPassFilterView: View {
    @StateObject var conductor = BPFOscillatorConductor()
    
    @State private var didTapSine:Bool = false
    @State private var didTapSquare:Bool = false
    @State private var didTapTriangle:Bool = false
    @State private var didTapSawtooth:Bool = false
    
    var body: some View {
        VStack {
            
            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
                .padding()
                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
            
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
                
            }
            
            HStack{
                ParameterSlider(text: "Amplitude",
                                parameter: self.$conductor.data.amplitude,
                                range: 0 ... 1)
                //                    .padding()
                VStack{
                    Text(" /1   ")
                    Text(" ")
                    Text(" ")
                }
            }
            
            
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
            
            
            Text("Band Pass Filter Controls:").foregroundColor(.pink).font(Font.body.bold()).padding()
            ParameterSlider(text: "Center Frequency",
                            parameter: self.$conductor.data.centerFrequency,
                            range: 12.0...20_000.0,
                            units: "Hertz")
            ParameterSlider(text: "Bandwidth",
                            parameter: self.$conductor.data.bandwidth,
                            range: 0.0...20_000.0,
                            units: "Hertz")
            
            
        }
        
        DryWetMixView(dry: conductor.osc, wet: conductor.filter, mix: conductor.dryWetMixer)
        
        
            .cookbookNavBarTitle("Band Pass Filter")
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


struct BandPassFilter_Previews: PreviewProvider {
    static var previews: some View {
        BandPassFilterView()
    }
}






