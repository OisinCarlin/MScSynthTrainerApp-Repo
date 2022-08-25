//
//  PlayBasicControls.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 10/08/2022.
//
// Basic Controls Submenu of Play Menu
//

import SwiftUI

struct PlayBasicControls: View {
    var body: some View {
        Form {
            Group {
                Section(header: Text("Play Basic Controls")) {
                    NavigationLink(destination: BasicControlsAmplitudeOscillatorView()){
                        HStack {
                            Image("lion")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Amplitude Control")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: BasicControlsPitchOscillatorView()){
                        HStack {
                            Image("sopranoSinger")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Pitch Control")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: BasicControlsKeyboardOscillatorView()){
                        HStack {
                            Image("keyboardSynth2")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Keyboard Control")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: BasicControlsGlideOscillatorView()){
                        HStack {
                            Image("trombone")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Glide Control")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
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

struct PlayBasicControls_Previews: PreviewProvider {
    static var previews: some View {
        PlayBasicControls()
    }
}
