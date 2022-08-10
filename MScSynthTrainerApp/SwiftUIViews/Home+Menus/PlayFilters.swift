//
//  PlayFilters.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 10/08/2022.
//

import SwiftUI

struct PlayFilters: View {
    var body: some View {
        Form {
            Group {
                Section(header: Text("Play Filters")) {
                    
                    NavigationLink(destination: LowPassFilterView()){
                        HStack {
                            Image("lowPassFilter")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Low Pass Filter")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: HighPassFilterView()){
                        HStack {
                            Image("highPassFilter")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("High Pass Filter")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: BandPassFilterView()){
                        HStack {
                            Image("bandPassFilter")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Band Pass Filter")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    NavigationLink(destination: BandRejectFilterView()){
                        HStack {
                            Image("bandRejectFilter")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Band Reject Filter")
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

struct PlayFilters_Previews: PreviewProvider {
    static var previews: some View {
        PlayFilters()
    }
}
