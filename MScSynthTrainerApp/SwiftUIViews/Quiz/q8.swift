//
//  q8.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 16/08/2022.
//
// Question View 8
// Filters: Green
//

import SwiftUI
import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import AudioToolbox
import AVFoundation
import AudioKitEX
import CAudioKitEX


struct q8: View {
    //Score Tracker
    @EnvironmentObject var scoreTracker: ScoreTracker
    @EnvironmentObject var questionCount: QuestionCount
    @EnvironmentObject var questionComplete: QuestionComplete
    
    
    // Store didtap values
    @State private var didTapA:Bool = false
    @State private var didTapB:Bool = false
    @State private var didTapC:Bool = false
    @State private var didTapD:Bool = false
    
    @State private var lock:Bool = false
    
    @State private var scoreLock:Bool = false
    
    
    @StateObject var conductor = Q8OscillatorConductor()
    
    
    var body: some View {
        
        VStack {
            
            Text("What kind of Filter is affecting the sound?")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding()
            
            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
                .padding()
                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
            
            ParameterSlider(text: "Cut-off Frequency",
                            parameter: self.$conductor.data.cutoffFrequency,
                            range: 12.0...3_000.0,
                            units: "Hertz")
                .frame(width: 300, height: 80)
            
            ParameterSlider(text: "Resonance",
                            parameter: self.$conductor.data.resonance,
                            range: -20...40,
                            units: "dB")
                .frame(width: 300, height: 80)
            
            // ****** Answer A **********************
            
            Button(action: {
                if(self.lock == false){
                    self.didTapA = true
                }
                self.lock = true
                
            }){
                Text("High-pass Filter")
                    .foregroundColor(self.didTapA ? .green : .black)
                    .font(Font.body.bold())
                    .padding()
                    .frame(maxWidth: 350)
                    .border(self.didTapA ? .green : .black, width: 3)
            }
            
            // ****************************************
            
            // ****** Answer B ************************
            
            Button(action: {
                if(self.lock == false){
                    self.didTapB = true
                }
                self.lock = true
                
            }){
                Text("Low-pass Filter")
                    .foregroundColor(self.didTapB ? .red : .black)
                
                    .font(Font.body.bold())
                    .padding()
                    .frame(maxWidth: 350)
                    .border(self.didTapB ? .red : .black, width: 3)
            }
            
            // ****************************************
            
            // ****** Answer C **********************
            
            Button(action: {
                if(self.lock == false){
                    self.didTapC = true
                }
                self.lock = true
                
            }){
                Text("Band-pass Filter")
                    .foregroundColor(self.didTapC ? .red : .black)
                    .font(Font.body.bold())
                    .padding()
                    .frame(maxWidth: 350)
                    .border(self.didTapC ? .red : .black, width: 3)
            }
            
            // ****************************************
            
            // ****** Answer D ************************
            
            Button(action: {
                if(self.lock == false){
                    self.didTapD = true
                }
                self.lock = true
                
            }){
                Text("Band-reject Filter")
                    .foregroundColor(self.didTapD ? .red : .black)
                
                    .font(Font.body.bold())
                    .padding()
                    .frame(maxWidth: 350)
                    .border(self.didTapD ? .red : .black, width: 3)
            }
            // ************ Response ******************
            
            //Correct
            if(self.didTapA){
                Text("Correct!")
                    .foregroundColor(.green)
                //                    .padding()
                
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
                    
                    // Test printing EnvironmentObject counters
                    print("                                                    ")
                    print("**** Start of EnvironmentObject Counters Printing ****")
                    print("                                                    ")
                    print("Score: " + String(scoreTracker.score))
                    print("Answers Attempted: " + String(questionCount.count))
                    print("Question Views Shown: " + String(questionComplete.completed))
                    print("                                                    ")
                    print("**** End of EnvironmentObject Counters Printing ****")
                    print("                                                    ")
                }
            }
            
            // Incorrect
            if(self.didTapB || self.didTapD || self.didTapC){
                Text("Incorrect, it was a High-pass filter.")
                    .foregroundColor(.red)
                //                    .padding()
                
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
                    
                    // Test printing EnvironmentObject counters
                    print("                                                    ")
                    print("**** Start of EnvironmentObject Counters Printing ****")
                    print("                                                    ")
                    print("Score: " + String(scoreTracker.score))
                    print("Answers Attempted: " + String(questionCount.count))
                    print("Question Views Shown: " + String(questionComplete.completed))
                    print("                                                    ")
                    print("**** End of EnvironmentObject Counters Printing ****")
                    print("                                                    ")
                }
            }
        }
        
        .onAppear {
            questionComplete.completed += 1
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
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

// Synth Data:


struct Q8OscillatorData {
    var isPlaying: Bool = false
    var frequency: AUValue = 440
    var amplitude: AUValue = 0.1
    var rampDuration: AUValue = 0.1
    
    var showKeyboard = false
    
    var cutoffFrequency: AUValue = 1_000
    var resonance: AUValue = 0
    var balance: AUValue = 1
}

class Q8OscillatorConductor: ObservableObject, KeyboardDelegate {
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
    
    @Published var data = Q8OscillatorData() {
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


struct q8_Previews: PreviewProvider {
    static var previews: some View {
        q8()
            .environmentObject(ScoreTracker())
            .environmentObject(QuestionCount())
            .environmentObject(QuestionComplete())
    }
}
