//
//  q7.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 16/08/2022.
//

import SwiftUI
import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import AudioToolbox
import AVFoundation
import AudioKitEX
import CAudioKitEX

// Envelopes: Blue

struct q7: View {
    
    @EnvironmentObject var scoreTracker: ScoreTracker
    @EnvironmentObject var questionCount: QuestionCount
    
    
    // Store didtap values
    @State private var didTapA:Bool = false
    @State private var didTapB:Bool = false
    @State private var didTapC:Bool = false
    @State private var didTapD:Bool = false
    
    @State private var lock:Bool = false
    
    @State private var scoreLock:Bool = false

    
    var body: some View {
        
        VStack {
            
//            Text("An enveloped sound that that takes a long time to reach it's peak amplititude has a ___ time?")
//                .font(.system(size: 12))
//                .fontWeight(.bold)
            
            Text("An enveloped sound that that takes ")
                .font(.system(size: 20))
                .fontWeight(.bold)
            
            Text("a long time to reach it's peak amplititude has ")
                .font(.system(size: 20))
                .fontWeight(.bold)
//                .padding()
            
            
            Text("a long ___ time?")
                .font(.system(size: 20))
                .fontWeight(.bold)
//                .padding()
            
//            Image("sawWave")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 300, height: 200)
//                .foregroundColor(.blue)
//                .padding()
            
            
            ADSRWidget { att, dec, sus, rel in
//                self.conductor.env.attackDuration = att
//                self.conductor.env.decayDuration = dec
//                self.conductor.env.sustainLevel = sus
//                self.conductor.env.releaseDuration = rel
            }
            .frame(width: 200, height: 150)
            
            
// ****** Answer A **********************
            
            Button(action: {
                if(self.lock == false){
                    self.didTapA = true
                }
                self.lock = true
                
            }){
                Text("Release")
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
                Text("Sustain")
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
                Text("Attack")
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
                Text("Decay")
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
                    //                    UserDefaults.standard.setQ1Result(value: 1)
                    
                    if(scoreLock == false){
                        scoreTracker.score += 1
                        questionCount.count += 1
                    }
                    
                    scoreLock = true
                }
            }
            
            // Incorrect
            if(self.didTapA || self.didTapB || self.didTapD){
                Text("Incorrect, it has a longer Attack time.")
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

            }
        }
        // Colour code border
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.blue, width: 16)
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

struct q7_Previews: PreviewProvider {
    static var previews: some View {
        q7()
    }
}
