//
//  SoundWavesLinkViews.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 12/08/2022.
//

import SwiftUI
import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import SwiftUI
import AudioToolbox
import AVFoundation
import AudioKitEX
import CAudioKitEX


struct SWAmplitudeLinkView: View {
    
    let systemImageName1: String
    let title: String
    let description: String
    
    
    var body: some View {
        
        VStack(spacing: 20){
            HStack{
                Image(systemImageName1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
                    .foregroundColor(.blue)
            }

            
            
            Text(title)
                .font(.title).bold()
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            NavigationLink(destination: BasicControlsAmplitudeOscillatorView()){
                Text("Tap here to Play with Amplitude Control").foregroundColor(.red).font(Font.body.bold())
            }.padding()
        }
        .padding(.horizontal, 40)
    }
}


struct SWPitchLinkView: View {
    
    let systemImageName1: String
    let title: String
    let description: String
    
    
    var body: some View {
        
        VStack(spacing: 20){
            HStack{
                Image(systemImageName1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
                    .foregroundColor(.blue)

            }

            
            
            Text(title)
                .font(.title).bold()
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            NavigationLink(destination: BasicControlsPitchOscillatorView()){
                Text("Tap here to Play with Pitch Control").foregroundColor(.red).font(Font.body.bold())
            }.padding()
        }
        .padding(.horizontal, 40)
    }
}
