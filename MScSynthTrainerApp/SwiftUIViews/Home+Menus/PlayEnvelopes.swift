//
//  PlayEnvelopes.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 10/08/2022.
//

import SwiftUI

struct PlayEnvelopes: View {
    var body: some View {
        Form {
            Group {
                Section(header: Text("Play ADSR Amplitude Envelopes")) {
                    
                    NavigationLink(destination: AmplitudeEnvelopeView()){
                        HStack {
                            Image("appADSR")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("ADSR Amplitude Envelope")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: LPFAmpEnvView()){
                        HStack {
                            Image("lowPassFilter")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("ADSR through Low Pass Filter")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: HPFAmpEnvView()){
                        HStack {
                            Image("highPassFilter")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("ADSR through High Pass Filter")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: BPFAmpEnvView()){
                        HStack {
                            Image("bandPassFilter")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("ADSR through Band Pass Filter")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: BRFAmpEnvView()){
                        HStack {
                            Image("bandRejectFilter")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("ADSR through Band Reject Filter")
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

struct PlayEnvelopes_Previews: PreviewProvider {
    static var previews: some View {
        PlayEnvelopes()
    }
}
