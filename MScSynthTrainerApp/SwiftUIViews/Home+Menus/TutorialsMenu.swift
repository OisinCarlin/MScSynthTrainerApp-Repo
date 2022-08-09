//
//  TutorialsMenu.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 10/07/2022.
//

import SwiftUI

// Only need one NavigationView Instance for Menu navigation
// .. in primary menu screen HomeVCSwiftUIView
// Can imbed multiple NavigationLink destinations between SwiftUI files
struct TutorialsMenu: View {
    var body: some View {
        Form {
            Group {
                Section(header: Text("Topics")) {
                    NavigationLink(destination: BasicControlsTutorial()){
                        HStack {
                            Image("controls")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Basic Controls")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Up, down, high, low. Learn the basics here")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    NavigationLink(destination: SoundWavesTutorial()){
                        HStack {
                            Image("soundWave2")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Sound Waves")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("...")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    NavigationLink(destination: OscillatorsAndWaveformsTutorial()){
                        HStack {
                            Image("waveOscillator")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Oscillators and Waveforms")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("...")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    NavigationLink(destination: FiltersTutorial()){
                        HStack {
                            Image("lowPassFilter")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Filters")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("...")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    NavigationLink(destination: EnvelopesTutorial()){
                        HStack {
                            Image("envelope")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Envelopes")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("...")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
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
        }.navigationBarTitle("Tutorials")
    }
}


struct TutorialsMenu_Previews: PreviewProvider {
    static var previews: some View {
        TutorialsMenu()
    }
}
