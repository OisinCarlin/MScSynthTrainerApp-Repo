//
//  QuizMenu.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 15/08/2022.
//

import SwiftUI



struct QuizMenu: View {
    
    @EnvironmentObject var scoreTracker: ScoreTracker
    @EnvironmentObject var questionCount: QuestionCount
    
    var body: some View {
        Form {
            Group {
                Section(header: Text("Quiz Topics")) {
                    NavigationLink(destination: q1()
                    .navigationBarBackButtonHidden(true)
                                   
                    ){
                        HStack {
//                            Image("controls")
//                                .resizable()
//                                .renderingMode(.original)
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 80)
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
                            scoreTracker.score = 0
                            questionCount.count = 0
                    }

//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
////                    .padding()
//                    .border(.red, width: 4)
                    
//                    .background(Color.red)
                    
//                    NavigationLink(destination: SoundWavesTutorial()){
//                        HStack {
//                            Image("soundWave2")
//                                .resizable()
//                                .renderingMode(.original)
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 80)
//                            VStack(alignment: .leading) {
//                                Text("Sound Waves")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                Text("...")
//                                    .font(.subheadline)
//                                    .foregroundColor(Color.gray)
//                                    .lineLimit(2)
//                            }
//                        }
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
////                    .padding()
//                    .border(.orange, width: 4)
//
//                    NavigationLink(destination: OscillatorsAndWaveformsTutorial()){
//                        HStack {
//                            Image("waveOscillator")
//                                .resizable()
//                                .renderingMode(.original)
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 80)
//                            VStack(alignment: .leading) {
//                                Text("Oscillators and Waveforms")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                Text("...")
//                                    .font(.subheadline)
//                                    .foregroundColor(Color.gray)
//                                    .lineLimit(2)
//                            }
//                        }
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
////                    .padding()
//                    .border(.yellow, width: 4)
//
//                    NavigationLink(destination: FiltersTutorial()){
//                        HStack {
//                            Image("lowPassFilter")
//                                .resizable()
//                                .renderingMode(.original)
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 80)
//                            VStack(alignment: .leading) {
//                                Text("Filters")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                Text("...")
//                                    .font(.subheadline)
//                                    .foregroundColor(Color.gray)
//                                    .lineLimit(2)
//                            }
//                        }
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
////                    .padding()
//                    .border(.green, width: 4)
//
//                    NavigationLink(destination: EnvelopesTutorial()){
//                        HStack {
//                            Image("envelope")
//                                .resizable()
//                                .renderingMode(.original)
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 80)
//                            VStack(alignment: .leading) {
//                                Text("Envelopes")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                Text("...")
//                                    .font(.subheadline)
//                                    .foregroundColor(Color.gray)
//                                    .lineLimit(2)
//                            }
//                        }
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
////                    .padding()
//                    .border(.blue, width: 4)
//                    NavigationLink(destination: TutorialsMenu()){
//                        HStack {
//                            Image("map")
//                                .resizable()
//                                .renderingMode(.original)
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 80)
//                            VStack(alignment: .leading) {
//                                Text("Approaches")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                Text("...")
//                                    .font(.subheadline)
//                                    .foregroundColor(Color.gray)
//                                    .lineLimit(2)
//                            }
//                        }
//                    }
                }
            }
        }.navigationBarTitle("Quiz")
        .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink(destination: MasterView()
                    .navigationBarBackButtonHidden(true)
                    ){
                        Text("Back to Main Menu")
    //                        .font(Font.body.bold())
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
