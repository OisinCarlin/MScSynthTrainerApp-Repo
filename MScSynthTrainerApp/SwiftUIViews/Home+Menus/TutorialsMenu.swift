//
//  TutorialsMenu.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 10/07/2022.
//
// Tutorials Menu View
//

import SwiftUI

struct TutorialsMenu: View {
    var body: some View {
        Form {
            Group {
                Section(header: Text("Tutorials Topics")) {
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
                                Text("Up, down, high, low. Learn the basics here.")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(.red, width: 4)
                    
                    
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
                                Text("What are sounds and what makes them wavey?")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(.orange, width: 4)
                    
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
                                Text("Learn the shapes that shape your tone!")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(.yellow, width: 4)
                    
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
                                Text("Filter out the noise and keep the good stuff.")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(.green, width: 4)
                    
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
                                Text("Wrap your sound up and send it away!")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(.blue, width: 4)
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
