//
//  HomeVCSwiftUIView.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 05/07/2022.
//  Navigation Menu Style Reference: (Rebeloper, 2019) :www.youtube.com/watch?v=7c2fBRM4gSA&ab_channel=Rebeloper-RebelDeveloper
//
// First Child SwiftUI View Hosted by UIKit ViewController: HomeVCSwiftUIView
// Main menu presented at top of SwiftUI NavigationView hierarchy: MasterView
//

import SwiftUI
import AudioKit
import AudioKitUI
import AVFoundation

// Child SwiftUI Hosted by UIKit ViewController
struct HomeVCSwiftUIView: View {
    
    var body: some View {
        
        
        // NavigationView declaration - top of hierarchy
        NavigationView {
            MasterView()
        }
        // Initialisation of EnvironmentObjects for Quiz Score, question answered and question views completed counts.
        .environmentObject(ScoreTracker())
        .environmentObject(QuestionCount())
        .environmentObject(QuestionComplete())
        
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

// Main menu view: First SwiftUI View presented in NavigationView
struct MasterView: View {
    
    // Completion to dismiss SwiftUIView
    var dismiss: (() -> Void)?
    var present: (()->Void)?
    
    
    let userFirstName = UserDefaults.standard.getUserFirstName()
    
    var body: some View {
        Form {
            Group {
                Section(header: Text("Main Menu")) {
                    NavigationLink(destination: TutorialsMenu()){
                        HStack {
                            Image("teacherInMusic")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Tutorials")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Start learning with our interactive tutorials!")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    NavigationLink(destination: PlayMenu()){
                        HStack {
                            Image("playKeyBoard")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Play")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Been through the tutorials? Play with synthesiser parts here.")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    NavigationLink(destination: QuizMenu()
                                    .navigationBarBackButtonHidden(true)
                    ){
                        HStack {
                            Image("quiz")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Quiz")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Test your learning so far with our quizzes!")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
                
            }
        }
        .navigationBarTitle("SynthTrainer")
        .navigationBarItems(
            trailing:
                HStack{
                }
        )
    }
}

struct HomeVCSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeVCSwiftUIView()
    }
}

