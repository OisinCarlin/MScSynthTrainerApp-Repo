//
//  q1.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 15/08/2022.
//

import SwiftUI

struct q1: View {
    

    
    @EnvironmentObject var scoreTracker: ScoreTracker
    
    
    // Store didtap values
    @State private var didTapA:Bool = false
    @State private var didTapB:Bool = false
    @State private var didTapC:Bool = false
    @State private var didTapD:Bool = false
    
    @State private var lock:Bool = false
    
    var body: some View {

        VStack {
        
        Text("Which waveform is this?")
            .font(.system(size: 30))
            .fontWeight(.bold)
            .padding()
            
            Image("sawWave")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 200)
                .foregroundColor(.blue)
                .padding()
            
            
        
// ****** Answer A **********************
            
            Text("Sine").onTapGesture {
                if(self.lock == false){
                    self.didTapA = true
                }
                self.lock = true
            }
            .foregroundColor(self.didTapA ? .red : .black)
            .font(Font.body.bold())
                .padding()
            .frame(maxWidth: 350)
                .border(self.didTapA ? .red : .black, width: 3)
            
// ****************************************
            
// ****** Answer B ************************
            
            Text("Square").onTapGesture {
                if(self.lock == false){
                    self.didTapB = true
                }
                self.lock = true
            }
            
            .foregroundColor(self.didTapB ? .red : .black)
            
            .font(Font.body.bold())
                .padding()
                .frame(maxWidth: 350)
                .border(self.didTapB ? .red : .black, width: 3)
            
// ****************************************

// ****** Answer C ************************
        
        Text("Triangle").onTapGesture {
            if(self.lock == false){
                self.didTapC = true
            }
            self.lock = true
        }
            
        .foregroundColor(self.didTapC ? .red : .black)

        .font(Font.body.bold())
            .padding()
            .frame(maxWidth: 350)
            .border(self.didTapC ? .red : .black, width: 3)
        
// ****************************************
            
            
// ****** Answer D ************************
        
        Text("Sawtooth").onTapGesture {
            if(self.lock == false){
                self.didTapD = true
            }
            self.lock = true
            
//            scoreTracker.score += 1
        }
        
        .foregroundColor(self.didTapD ? .green : .black)

        .font(Font.body.bold())
            .padding()
            .frame(maxWidth: 350)
            .border(self.didTapD ? .green : .black, width: 3)
        
// ****************************************
            
// ************ Response ******************
            
            //Correct
            if(self.didTapD){
                Text("Correct!")
                    .foregroundColor(.green)
                    .padding()
                
                NavigationLink(destination: q2()){
                    Text("Next Question")
                        .foregroundColor(.blue)

                    .font(Font.body.bold())
                        .padding()
                        .frame(maxWidth: 350)
                        .border(.blue, width: 3)
                }.onAppear{
//                    UserDefaults.standard.setQ1Result(value: 1)
                    
                    scoreTracker.score += 1
  
                }
            }
            
            // Incorrect
            if(self.didTapA || self.didTapB || self.didTapC){
                Text("Sorry, that was incorrect. This is a Sawtooth Wave")
                    .foregroundColor(.red)
                    .padding()
                
                NavigationLink(destination: q2()){
                    Text("Next Question")
                        .foregroundColor(.blue)

                    .font(Font.body.bold())
                        .padding()
                        .frame(maxWidth: 350)
                        .border(.blue, width: 3)
                }
                
//                .onTapGesture {
//                    UserDefaults.standard.setQ1Result(value: 0)
//                }
            }
        }
        // Colour code border
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .border(.yellow, width: 16)
    }
}

struct q1_Previews: PreviewProvider {
    static var previews: some View {
        q1()
    }
}
