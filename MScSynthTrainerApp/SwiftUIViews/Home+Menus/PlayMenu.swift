//
//  PlayMenu.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 10/08/2022.
//

import SwiftUI

struct PlayMenu: View {
    var body: some View {
        Form {
            Group {
                Section(header: Text("Play Topics")) {
                    NavigationLink(destination: PlayBasicControls()){
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
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
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
                    NavigationLink(destination: PlayOscillatorsAndWaveforms()){
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
                    NavigationLink(destination: PlayFilters()){
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
                    NavigationLink(destination: PlayEnvelopes()){
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
                }
            }
        }.navigationBarTitle("Play")
    }
}

struct PlayMenu_Previews: PreviewProvider {
    static var previews: some View {
        PlayMenu()
    }
}
