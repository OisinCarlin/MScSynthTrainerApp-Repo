//
//  QuizMenu.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 15/08/2022.
//
// Quiz Section Landing View
// Resets Score and Question Counting and Completion EnviromentObjects OnAppear
//

import SwiftUI

struct QuizMenu: View {
    
    @EnvironmentObject var scoreTracker: ScoreTracker
    @EnvironmentObject var questionCount: QuestionCount
    @EnvironmentObject var questionComplete: QuestionComplete
    
    var body: some View {
        Form {
            Group {
                Section(header: Text("")) {
                    NavigationLink(destination: QHost1()
                                    .navigationBarBackButtonHidden(true)
                                   
                    ){
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Start Quiz")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    .onAppear {
                        
                        // Reset Score and Question Counting and Completion EnviromentObjects
                        scoreTracker.score = 0
                        questionCount.count = 0
                        questionComplete.completed = 0
                    }
                }
            }
        }.navigationBarTitle("Quiz")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink(destination: MasterView()
                                    .navigationBarBackButtonHidden(true)
                    ){
                        Text("Back to Main Menu")
                            .foregroundColor(.blue)
                    }
                }
            }
    }
}

struct QuizMenu_Previews: PreviewProvider {
    static var previews: some View {
        QuizMenu()
    }
}
