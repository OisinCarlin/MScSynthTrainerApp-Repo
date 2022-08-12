//
//  AmplitudeEnvelope.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 09/08/2022.
//


import AudioKit
import AudioKitEX
import AudioKitUI
import AudioToolbox
import AVFoundation
import SoundpipeAudioKit
import SwiftUI

//: ## Amplitude Envelope
//: A surprising amount of character can be added to a sound by changing its amplitude over time.
//: A very common means of defining the shape of amplitude is to use an ADSR envelope which stands for
//: Attack, Sustain, Decay, Release.
//: * Attack is the amount of time it takes a sound to reach its maximum volume.  An example of a fast attack is a
//:   piano, where as a cello can have a longer attack time.
//: * Decay is the amount of time after which the peak amplitude is reached for a lower amplitude to arrive.
//: * Sustain is not a time, but a percentage of the peak amplitude that will be the the sustained amplitude.
//: * Release is the amount of time after a note is let go for the sound to die away to zero.


struct AmpEnvData {
    var amplitude: AUValue = 0.5
    var rampDuration: AUValue = 0.1
}

class AmplitudeEnvelopeConductor: ObservableObject, KeyboardDelegate {
    let engine = AudioEngine()
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

    var osc: Oscillator
    var env: AmplitudeEnvelope
    var fader: Fader
    
    @Published var data = AmpEnvData() {
        didSet {
            osc.$amplitude.ramp(to: data.amplitude, duration: data.rampDuration)
        }
    }

    init() {
        osc = Oscillator()
        env = AmplitudeEnvelope(osc)
        fader = Fader(env)
        osc.amplitude = 1
        engine.output = fader
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
        osc.stop()
        engine.stop()
    }
}

struct AmplitudeEnvelopeView: View {
    @StateObject var conductor = AmplitudeEnvelopeConductor()
    
    @State private var didTapSine:Bool = false
    @State private var didTapSquare:Bool = false
    @State private var didTapTriangle:Bool = false
    @State private var didTapSawtooth:Bool = false

    var body: some View {
        VStack {
            
            Text("Amplitude Envelope ADSR Controls:").foregroundColor(.pink).font(Font.body.bold()).padding()
            
            ADSRWidget { att, dec, sus, rel in
                self.conductor.env.attackDuration = att
                self.conductor.env.decayDuration = dec
                self.conductor.env.sustainLevel = sus
                self.conductor.env.releaseDuration = rel
            }
//            NodeOutputView(conductor.env)
            NodeRollingView(conductor.fader, color: .red)
            
            Text("Oscillator Waveform Controls:").foregroundColor(.pink).font(Font.body.bold()).padding()
            
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
                                range: 0 ... 1).padding()
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

        }.cookbookNavBarTitle("Amplitude Envelope")
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

struct AmplitudeEnvelopeView_Previews: PreviewProvider {
    static var previews: some View {
        AmplitudeEnvelopeView()
    }
}
