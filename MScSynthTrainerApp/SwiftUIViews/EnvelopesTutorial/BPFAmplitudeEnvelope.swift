//
//  BPFAmplitudeEnvelope.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 09/08/2022.
//
// Amplitude Envelope with Band Pass Filter Example View
//

import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import SwiftUI
import AudioToolbox
import AVFoundation
import AudioKitEX
import CAudioKitEX



struct BPFAmpEnvData {
    var isPlaying: Bool = false
    var frequency: AUValue = 440
    var amplitude: AUValue = 0.5
    var rampDuration: AUValue = 0.1
    
    var showKeyboard = false
    
    var centerFrequency: AUValue = 2_000.0
    var bandwidth: AUValue = 100.0
    var balance: AUValue = 1
}

class BPFAmpEnvConductor: ObservableObject, KeyboardDelegate {
    var osc = Oscillator()
    
    let engine = AudioEngine()
    let filter: BandPassFilter
    let dryWetMixer: DryWetMixer
    
    var currentNote = 0
    
    
    func noteOn(note: MIDINoteNumber) {
        
        if note != currentNote {
            env.closeGate()
        }
        osc.frequency = note.midiNoteToFrequency()
        env.openGate()
    }
    
    func noteOff(note: MIDINoteNumber) {
        env.closeGate()
    }
    
    var env: AmplitudeEnvelope
    var fader: Fader
    
    @Published var data = BPFAmpEnvData() {
        didSet {
            
            filter.centerFrequency = data.centerFrequency
            filter.bandwidth = data.bandwidth
            
            osc.$amplitude.ramp(to: data.amplitude, duration: data.rampDuration)
        }
    }
    
    init() {
        osc = Oscillator()
        env = AmplitudeEnvelope(osc)
        fader = Fader(env)
        osc.amplitude = 1
        
        
        filter = BandPassFilter(fader)
        dryWetMixer = DryWetMixer(fader, filter)
        engine.output = dryWetMixer
    }
    
    func start() {
        osc.start()
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



struct BPFAmpEnvView: View {
    @StateObject var conductor = BPFAmpEnvConductor()
    
    @State private var didTapSine:Bool = false
    @State private var didTapSquare:Bool = false
    @State private var didTapTriangle:Bool = false
    @State private var didTapSawtooth:Bool = false
    
    var body: some View {
        
        VStack {
            
            
            ADSRWidget { att, dec, sus, rel in
                self.conductor.env.attackDuration = att
                self.conductor.env.decayDuration = dec
                self.conductor.env.sustainLevel = sus
                self.conductor.env.releaseDuration = rel
            }
            
            NodeRollingView(conductor.dryWetMixer, color: .red)
            
            
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
            
            
            HStack{
                ParameterSlider(text: " Master Amplitude",
                                parameter: self.$conductor.data.amplitude,
                                range: 0 ... 1)
                    .padding()
                VStack{
                    Text(" /1   ")
                    Text(" ")
                    Text(" ")
                }
            }
            
            KeyboardControl(firstOctave: 3,
                            octaveCount: 1,
                            polyphonicMode: false,
                            delegate: conductor)
            
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
        
        
        .cookbookNavBarTitle("BPF and Envelope")
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


struct BPFAmpEnv_Previews: PreviewProvider {
    static var previews: some View {
        BPFAmpEnvView()
    }
}
