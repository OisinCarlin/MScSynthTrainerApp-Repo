//
//  HomeVCSwiftUIView.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 05/07/2022.
//  Navigation Menu Style Reference: Rebeloper
//www.youtube.com/watch?v=7c2fBRM4gSA&ab_channel=Rebeloper-RebelDeveloper
//

import SwiftUI
import AudioKit
import AudioKitUI
import AVFoundation

// Only need one NavigationView Instance for Menu navigation
// .. in primary menu screen HomeVCSwiftUIView
// Can imbed multiple NavigationLink destinations between SwiftUI files



struct HomeVCSwiftUIView: View {
    
    //Score Tracker
//    @StateObject var scoreTracker = ScoreTracker()
    
    var body: some View {
        // If reverting from Menu Navigation view, delete MasterView, TutorialsMenu and DynamicOscillatorView and just present text
        
        //        Text("Welcome to SynthTrainer!")
        //            .padding(25)
        NavigationView {
            MasterView()
        }
        //Score Tracker
        .environmentObject(ScoreTracker())
        .environmentObject(QuestionCount())
        .environmentObject(QuestionArray())
        
        
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        
        
    }
}

struct MasterView: View {
    
    // Completion to dismiss SwiftUIView
    var dismiss: (() -> Void)?
    var present: (()->Void)?
    
    
    let userFirstName = UserDefaults.standard.getUserFirstName()
    
    var body: some View {
        Form {
            Group {
                Section(header: Text(userFirstName)) {
                    //                    NavigationLink(destination: TutorialsMenu()){
                    //                        HStack {
                    //                            Image("hello")
                    //                                .resizable()
                    //                                .renderingMode(.original)
                    //                                .aspectRatio(contentMode: .fit)
                    //                                .frame(width: 80, height: 80)
                    //                            VStack(alignment: .leading) {
                    //                                Text("Welcome")
                    //                                    .font(.headline)
                    //                                    .fontWeight(.bold)
                    //                                Text("Welcome to SynthTrainer! Here's a quick introduction to our app.")
                    //                                    .font(.subheadline)
                    //                                    .foregroundColor(Color.gray)
                    //                                    .lineLimit(2)
                    //                            }
                    //                        }
                    //                    }
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
//                    NavigationLink(destination: TutorialsMenu()){
                        //                        HStack {
                        //                            Image("progress")
                        //                                .resizable()
                        //                                .renderingMode(.original)
                        //                                .aspectRatio(contentMode: .fit)
                        //                                .frame(width: 80, height: 80)
                        //                            VStack(alignment: .leading) {
                        //                                Text("Progress")
                        //                                    .font(.headline)
                        //                                    .fontWeight(.bold)
                        //                                Text("Check out how your sonic journey is going so far.")
                        //                                    .font(.subheadline)
                        //                                    .foregroundColor(Color.gray)
                        //                                    .lineLimit(2)
                        //                            }
                        //                        }
                        //                    }
                    }
                    
                }
            }
            .navigationBarTitle("SynthTrainer")
            .navigationBarItems(
                trailing:
                    HStack{
                        //
                    }
            )
        }
    }
    
    
    
    struct HomeVCSwiftUIView_Previews: PreviewProvider {
        static var previews: some View {
            HomeVCSwiftUIView()
        }
    }
    
