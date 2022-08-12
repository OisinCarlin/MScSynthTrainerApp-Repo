//
//  PlayOscillatorsAndWaveforms.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 10/08/2022.
//

import SwiftUI

struct PlayOscillatorsAndWaveforms: View {
    var body: some View {
        Form {
            Group {
                Section(header: Text("Play Oscillators and Waveforms")) {
                    
                    NavigationLink(destination: OWSineOscillatorView()){
                        HStack {
                            Image("sineWave")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Sine Waveform")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: OWSquareOscillatorView()){
                        HStack {
                            Image("squareWave")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Square Waveform")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: OWTriangleOscillatorView()){
                        HStack {
                            Image("triangleWave")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Triangle Waveform")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: OWSawtoothOscillatorView()){
                        HStack {
                            Image("sawWave")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Sawtooth Waveform")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: PWMOscillatorView()){
                        HStack {
                            Image("pwm")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Pulse Width Modulation")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination:  OWOscillatorView()){
                        HStack {
                            Image("vco")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Oscillator with Pitch and Amplitude")
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

struct PlayOscillatorsAndWaveforms_Previews: PreviewProvider {
    static var previews: some View {
        PlayOscillatorsAndWaveforms()
    }
}

