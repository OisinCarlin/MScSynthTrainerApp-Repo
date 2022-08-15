//
//  QuizSummary.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 15/08/2022.
//

import SwiftUI


//struct ScoreView: View {
//    @EnvironmentObject var settings: GameSettings
//
//    var body: some View {
//        Text("Score: \(settings.score)")
//    }
//}

struct QuizSummary: View {
    
    
    //Score Tracker
    @EnvironmentObject var scoreTracker: ScoreTracker
    
//
//    // Get UserDefaults results
//    @State private var q1result:Int = UserDefaults.standard.getQ1Result()
//
//    @State private var q2result:Int = UserDefaults.standard.getQ2Result()
    
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
            
            Text("You scored:  " + scoreString + " out of 2")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding()
            
            NavigationLink(destination: QuizMenu()){
//                Text("Finish Quiz / Save Result")
                
                Text("Complete")
                    .foregroundColor(.blue)
                
                    .font(Font.body.bold())
                    .padding()
                    .frame(maxWidth: 350)
                    .border(.blue, width: 3)
            }.onTapGesture {
                //                UserDefaults.standard.setQ1Result(value: 0)
            }
            
            
            
        }

    }
}

struct QuizSummary_Previews: PreviewProvider {
    static var previews: some View {
        QuizSummary()
    }
}
