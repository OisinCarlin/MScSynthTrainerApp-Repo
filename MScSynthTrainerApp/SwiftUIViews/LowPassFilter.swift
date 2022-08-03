
import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import SwiftUI
import AudioToolbox
import AVFoundation
import AudioKitEX
import CAudioKitEX



struct LPFOscillatorData {
    var isPlaying: Bool = false
    var frequency: AUValue = 440
    var amplitude: AUValue = 0.1
    var rampDuration: AUValue = 0.1
    
    var showKeyboard = false
    
    var cutoffFrequency: AUValue = 1_000
    var resonance: AUValue = 0
    var balance: AUValue = 1
}

class LPFOscillatorConductor: ObservableObject, KeyboardDelegate {
    var osc = Oscillator()
    
    let engine = AudioEngine()
    let filter: LowPassFilter
    let dryWetMixer: DryWetMixer
    
    
    func noteOn(note: MIDINoteNumber) {
        data.isPlaying = true
        data.frequency = note.midiNoteToFrequency()
    }
    
    func noteOff(note: MIDINoteNumber) {
        data.isPlaying = false
    }
    
    @Published var data = LPFOscillatorData() {
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
        filter = LowPassFilter(osc)
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



struct LowPassFilterView: View {
    @StateObject var conductor = LPFOscillatorConductor()
    
    var body: some View {
        //                ScrollView {
        VStack {
            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(.green).font(Font.body.bold())
            
            HStack {
                Spacer()
                Text("Sine").onTapGesture {
                    self.conductor.osc.setWaveform(Table(.sine))
                }
                Spacer()
                Text("Square").onTapGesture {
                    self.conductor.osc.setWaveform(Table(.square))
                }
                Spacer()
                Text("Triangle").onTapGesture {
                    self.conductor.osc.setWaveform(Table(.triangle))
                }
                Spacer()
                Text("Sawtooth").onTapGesture {
                    self.conductor.osc.setWaveform(Table(.sawtooth))
                }
                Spacer()
            }
            if(self.conductor.data.showKeyboard == false){
                ParameterSlider(text: "Frequency",
                                parameter: self.$conductor.data.frequency,
                                range: 20...880)
                //                        .padding()
            }
            
            ParameterSlider(text: "Amplitude",
                            parameter: self.$conductor.data.amplitude,
                            range: 0 ... 1)
            //                    .padding()
            //               NodeOutputView(conductor.osc)
            
            //Show Keyboard button
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
            }.foregroundColor(.orange).font(Font.body.bold())
            
            if(self.conductor.data.showKeyboard){
                KeyboardControl(firstOctave: 3,
                                octaveCount: 2,
                                polyphonicMode: false,
                                delegate: conductor)
            }
            
            
            Text("Low Pass Filter Controls:").foregroundColor(.pink).font(Font.body.bold()).padding()
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


                    .cookbookNavBarTitle("Low Pass Filter")
            .onAppear {
                self.conductor.start()
            }
            .onDisappear {
                self.conductor.stop()
            }
        
    }
    
}


struct LowPassFilter_Previews: PreviewProvider {
    static var previews: some View {
        LowPassFilterView()
    }
}



