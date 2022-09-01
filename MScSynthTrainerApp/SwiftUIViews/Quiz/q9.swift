//
//  q9.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 16/08/2022.
//
// Question View 9
// Basic Controls: Red
//

import SwiftUI
import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import AudioToolbox
import AVFoundation
import AudioKitEX
import CAudioKitEX


struct q9: View {
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
    
    @StateObject var conductor = PWMOscillatorConductor()
    
    
    var body: some View {
        
        VStack {
            
            Text("Which Oscillator parameter does the slider control?")
                .font(.system(size: 20))
                .fontWeight(.bold)
            
            HStack{
                ParameterSlider(text: "",
                                parameter: self.$conductor.data.rampDuration,
                                range: 0...10).padding()
                VStack{
                    Text("secs ")
                    Text(" ")
                    Text(" ")
                }
            }
            .frame(width: 300, height: 80)
            
            KeyboardControl(firstOctave: 3,
                            octaveCount: 1,
                            polyphonicMode: false,
                            delegate: conductor)
                .frame(width: 300, height: 80)
            
            // ****** Answer A **********************
            
            Button(action: {
                if(self.lock == false){
                    self.didTapA = true
                }
                self.lock = true
                
            }){
                Text("Pitch / Frequency")
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
                Text("Amplitude / Volume")
                    .foregroundColor(self.didTapB ? .red : .black)
                
                    .font(Font.body.bold())
                    .padding()
                    .frame(maxWidth: 350)
                    .border(self.didTapB ? .red : .black, width: 3)
            }
            // ****************************************
            
            // ****** Answer C ************************
            
            Button(action: {
                if(self.lock == false){
                    self.didTapC = true
                }
                self.lock = true
                
            }){
                Text("Glide time")
                    .foregroundColor(self.didTapC ? .green : .black)
                
                    .font(Font.body.bold())
                    .padding()
                    .frame(maxWidth: 350)
                    .border(self.didTapC ? .green : .black, width: 3)
            }
            
            
            // ****************************************
            
            
            // ****** Answer D ************************
            
            Button(action: {
                if(self.lock == false){
                    self.didTapD = true
                }
                self.lock = true
                
            }){
                Text("Decay Time")
                    .foregroundColor(self.didTapD ? .red : .black)
                
                    .font(Font.body.bold())
                    .padding()
                    .frame(maxWidth: 350)
                    .border(self.didTapD ? .red : .black, width: 3)
            }
            
            // ****************************************
            
            // ************ Response ******************
            
            
            
            
            //Correct
            if(self.didTapC){
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
                }.onAppear{
                    
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
            if(self.didTapB || self.didTapD || self.didTapA){
                Text("Incorrect, the slider controls Glide Time.")
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
        .onAppear{
            questionComplete.completed += 1
        }
        // Colour code border
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.red, width: 16)
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
        .onAppear {
            self.conductor.start()
        }
        .onDisappear {
            self.conductor.stop()
        }
    }
}

struct q9_Previews: PreviewProvider {
    static var previews: some View {
        q9()
            .environmentObject(ScoreTracker())
            .environmentObject(QuestionCount())
            .environmentObject(QuestionComplete())
    }
}
