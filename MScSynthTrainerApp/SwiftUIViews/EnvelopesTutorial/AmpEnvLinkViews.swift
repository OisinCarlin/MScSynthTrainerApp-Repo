//
//  AmpEnvLinkViews.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 09/08/2022.
//
//
// Amplitude Envelopes Example Linking Onboard Views
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

struct AmpEnvLinkView: View {
    
    let systemImageName1: String
    let title: String
    let description: String
    
    
    var body: some View {
        
        VStack(spacing: 20){
            HStack{
                Image(systemImageName1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 120)
                    .foregroundColor(.blue)
            }
            
            
            Text(title)
                .font(.title).bold()
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            NavigationLink(destination: AmplitudeEnvelopeView()){
                Text("Tap here to Play with Amplitude Envelope").foregroundColor(.red).font(Font.body.bold())
            }.padding()
        }
        .padding(.horizontal, 40)
    }
}

struct FiltersAmpEnvLinkView: View {
    
    let systemImageName1: String
    let title: String
    let description: String
    
    
    var body: some View {
        
        VStack(spacing: 20){
            HStack{
                Image(systemImageName1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                    .foregroundColor(.blue)
                
            }
            
            
            Text(title)
                .font(.title).bold()
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            NavigationLink(destination: LPFAmpEnvView()){
                Text("Tap here to Play Enveloped Sound through Low Pass Filter").foregroundColor(.blue).font(Font.body.bold())
            }
            
            NavigationLink(destination: HPFAmpEnvView()){
                Text("Tap here to Play Enveloped Sound through High Pass Filter").foregroundColor(.purple).font(Font.body.bold())
            }
            
            NavigationLink(destination: BPFAmpEnvView()){
                Text("Tap here to Play Enveloped Sound through Band Pass Filter").foregroundColor(.pink).font(Font.body.bold())
            }
            
            NavigationLink(destination: BRFAmpEnvView()){
                Text("Tap here to Play Enveloped Sound through Band Reject Filter").foregroundColor(.red).font(Font.body.bold())
            }
            
        }
        .padding(.horizontal, 40)
    }
}
