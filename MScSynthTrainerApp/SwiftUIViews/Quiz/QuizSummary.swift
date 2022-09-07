//
//  QuizSummary.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 15/08/2022.
//
// Quiz Summary: Presents User Score and Questions Completed from incremented EnviromentObject variables.
//

import SwiftUI

struct QuizSummary: View {
    
    //Score Tracker
    @EnvironmentObject var scoreTracker: ScoreTracker
    @EnvironmentObject var questionCount: QuestionCount
    
    var body: some View {
        VStack {
            
            Text("Congratulations")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding()
            Image("progress")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 200)
                .foregroundColor(.blue)
                .padding()
            
            let scoreString = String(scoreTracker.score)
            let countString = String(questionCount.count)
            
            Text("You scored:  " + scoreString + " out of " + countString)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding()
            
            NavigationLink(destination: QuizMenu()
                            .navigationBarBackButtonHidden(true)
            ){
                
                Text("Complete")
                    .foregroundColor(.blue)
                
                    .font(Font.body.bold())
                    .padding()
                    .frame(maxWidth: 350)
                    .border(.blue, width: 3)
            }.onTapGesture {
            }
        }
        .onAppear{
            
            // Test printing EnvironmentObject counters
            print("                                                    ")
            print("**** Start of EnvironmentObject Counters Printing ****")
            print("                                                    ")
            print("Score: " + String(scoreTracker.score))
            print("Answers Attempted: " + String(questionCount.count))
            print("                                                    ")
            print("**** End of EnvironmentObject Counters Printing ****")
            print("                                                    ")
        }
        
    }
}

struct QuizSummary_Previews: PreviewProvider {
    static var previews: some View {
        QuizSummary()
            .environmentObject(ScoreTracker())
            .environmentObject(QuestionCount())
    }
}
