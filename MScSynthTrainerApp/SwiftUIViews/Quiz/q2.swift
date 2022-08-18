//
//  q2.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 15/08/2022.
//

// Filters: Green

import SwiftUI
import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import AudioToolbox
import AVFoundation
import AudioKitEX
import CAudioKitEX

struct q2: View {
    
    //Score Tracker
    @EnvironmentObject var scoreTracker: ScoreTracker
    @EnvironmentObject var questionCount: QuestionCount
    
    
    // Store didtap values
    @State private var didTapA:Bool = false
    @State private var didTapB:Bool = false
    @State private var didTapC:Bool = false
    @State private var didTapD:Bool = false
    
    @State private var lock:Bool = false
    
    @State private var scoreLock:Bool = false
    
    
    @StateObject var conductor = Q2OscillatorConductor()
    
    
    var body: some View {
        
        VStack {
            
            Text("Which Filter parameter does this Slider Control on the Low Pass Filter?")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding()
            
            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
                .padding()
                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
            
            ParameterSlider(text: "",
                            parameter: self.$conductor.data.cutoffFrequency,
                            range: 12.0...3_000.0,
                            units: "Hertz")
                .frame(width: 300, height: 100)
//                .padding()
            
// ****** Answer A **********************
            
            Button(action: {
                if(self.lock == false){
                    self.didTapA = true
                }
                self.lock = true
                
            }){
                Text("Resonance")
                    .foregroundColor(self.didTapA ? .red : .black)
                    .font(Font.body.bold())
                    .padding()
                    .frame(maxWidth: 350)
                    .border(self.didTapA ? .red : .black, width: 3)
            }
            
// ****************************************
            
// ****** Answer B ************************
            
            Button(action: {
                if(self.lock == false){
                    self.didTapB = true
                }
                self.lock = true
                
            }){
                Text("Cut-off Frequency")
                    .foregroundColor(self.didTapB ? .green : .black)
                    
                    .font(Font.body.bold())
                    .padding()
                    .frame(maxWidth: 350)
                    .border(self.didTapB ? .green : .black, width: 3)
            }
            
// ************ Response ******************
            
            //Correct
            if(self.didTapB){
                Text("Correct!")
                    .foregroundColor(.green)
                    .padding()
                
                NavigationLink(destination: QHost1()
                .navigationBarBackButtonHidden(true)

                ){
                    Text("Next")
                        .foregroundColor(.blue)
                    
                        .font(Font.body.bold())
                        .padding()
                        .frame(maxWidth: 350)
                        .border(.blue, width: 3)
                }
                .onAppear {
//                    UserDefaults.standard.setQ2Result(value: 1)
                    
                    if(scoreLock == false){
                        scoreTracker.score += 1
                        questionCount.count += 1
                    }
                    
                    scoreLock = true
                }
            }
            
            // Incorrect
            if(self.didTapA || self.didTapD || self.didTapC){
                Text("Incorrect, that was incorrect. This slider controls Cut-off Frequency")
                    .foregroundColor(.red)
                    .padding()
                
                NavigationLink(destination: QHost1()
                .navigationBarBackButtonHidden(true)
                               
                ){
                    Text("Next")
                        .foregroundColor(.blue)
                    
                        .font(Font.body.bold())
                        .padding()
                        .frame(maxWidth: 350)
                        .border(.blue, width: 3)
                }.onAppear{
                    questionCount.count += 1
                }
//                .onTapGesture {
//                    UserDefaults.standard.setQ2Result(value: 0)
//                }
            }
        }
        .onAppear {
            self.conductor.start()
            
            self.conductor.osc.setWaveform(Table(.square))
            
        }
        .onDisappear {
            self.conductor.stop()
        }
        // Colour code border
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.green, width: 16)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                NavigationLink(destination: QuizSummary()
                .navigationBarBackButtonHidden(true)
                ){
                    Text("Quit Quiz")
//                        .font(Font.body.bold())
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
}


// Synth Data:


struct Q2OscillatorData {
    var isPlaying: Bool = false
    var frequency: AUValue = 440
    var amplitude: AUValue = 0.1
    var rampDuration: AUValue = 0.1
    
    var showKeyboard = false
    
    var cutoffFrequency: AUValue = 1_000
    var resonance: AUValue = 0
    var balance: AUValue = 1
}

class Q2OscillatorConductor: ObservableObject, KeyboardDelegate {
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
    
    @Published var data = Q2OscillatorData() {
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



//struct Q2FilterView: View {
//    @StateObject var conductor = Q2OscillatorConductor()
//
//    @State private var didTapSine:Bool = false
//    @State private var didTapSquare:Bool = false
//    @State private var didTapTriangle:Bool = false
//    @State private var didTapSawtooth:Bool = false
//
//    var body: some View {
//        //                ScrollView {
//        VStack {
//            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
//                self.conductor.data.isPlaying.toggle()
//            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
//                .padding()
//                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
//
//
//            HStack {
//                Spacer()
//                Text("Sine").onTapGesture {
//                    self.conductor.osc.setWaveform(Table(.sine))
//
//                    self.didTapSine = true
//                    self.didTapSquare = false
//                    self.didTapTriangle = false
//                    self.didTapSawtooth = false
//                }
//                .foregroundColor(didTapSine ? Color.red : Color.black).font(Font.body.bold())
//                Spacer()
//
//                Text("Square").onTapGesture {
//                    self.conductor.osc.setWaveform(Table(.square))
//
//                    self.didTapSine = false
//                    self.didTapSquare = true
//                    self.didTapTriangle = false
//                    self.didTapSawtooth = false
//                }
//                .foregroundColor(didTapSquare ? Color.red : Color.black).font(Font.body.bold())
//                Spacer()
//
//                Text("Triangle").onTapGesture {
//                    self.conductor.osc.setWaveform(Table(.triangle))
//
//                    self.didTapSine = false
//                    self.didTapSquare = false
//                    self.didTapTriangle = true
//                    self.didTapSawtooth = false
//                }                .foregroundColor(didTapTriangle ? Color.red : Color.black).font(Font.body.bold())
//                Spacer()
//
//                Text("Sawtooth").onTapGesture {
//                    self.conductor.osc.setWaveform(Table(.sawtooth))
//
//                    self.didTapSine = false
//                    self.didTapSquare = false
//                    self.didTapTriangle = false
//                    self.didTapSawtooth = true
//                }                .foregroundColor(didTapSawtooth ? Color.red : Color.black).font(Font.body.bold())
//                Spacer()
//            }
//            if(self.conductor.data.showKeyboard == false){
//                HStack{
//                    ParameterSlider(text: "Frequency",
//                                    parameter: self.$conductor.data.frequency,
//                                    range: 20...880).padding()
//                    VStack{
//                        Text("Hz ")
//                        Text(" ")
//                        Text(" ")
//                    }
//
//                }
//                //                        .padding()
//            }
//
//            HStack{
//                ParameterSlider(text: "Amplitude",
//                                parameter: self.$conductor.data.amplitude,
//                                range: 0 ... 1)
//                //                    .padding()
//                VStack{
//                    Text(" /1   ")
//                    Text(" ")
//                    Text(" ")
//                }
//            }
//            //                    .padding()
//            //               NodeOutputView(conductor.osc)
//
//            //Show Keyboard button
//            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
//                self.conductor.data.showKeyboard.toggle()
//            }.foregroundColor(.orange).font(Font.body.bold())
//
//            if(self.conductor.data.showKeyboard){
//                KeyboardControl(firstOctave: 3,
//                                octaveCount: 1,
//                                polyphonicMode: false,
//                                delegate: conductor)
//            }
//
//
//            Text("Low Pass Filter Controls:").foregroundColor(.pink).font(Font.body.bold())
//
//                .padding()
//            ParameterSlider(text: "Cutoff Frequency",
//                            parameter: self.$conductor.data.cutoffFrequency,
//                            range: 12.0...3_000.0,
//                            units: "Hertz")
//            ParameterSlider(text: "Resonance",
//                            parameter: self.$conductor.data.resonance,
//                            range: -20...40,
//                            units: "dB")
//            //            ParameterSlider(text: "Filter Mix",
//            //                            parameter: self.$conductor.data.balance,
//            //                            range: 0...1,
//            //                            units: "%")
//
//
//        }
//
//        DryWetMixView(dry: conductor.osc, wet: conductor.filter, mix: conductor.dryWetMixer)
//
//
//            .cookbookNavBarTitle("Low Pass Filter")
//            .onAppear {
//                self.conductor.start()
//
//                self.conductor.osc.setWaveform(Table(.sine))
//
//                self.didTapSine = true
//                self.didTapSquare = false
//                self.didTapTriangle = false
//                self.didTapSawtooth = false
//            }
//            .onDisappear {
//                self.conductor.stop()
//            }
//
//    }
//
//}

struct q2_Previews: PreviewProvider {
    static var previews: some View {
        q2()
    }
}
