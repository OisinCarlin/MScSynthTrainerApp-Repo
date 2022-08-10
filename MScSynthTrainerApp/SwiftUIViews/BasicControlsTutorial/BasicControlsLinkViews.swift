//
//  BasicControlsLinkViews.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 10/08/2022.
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

struct BCPitchLinkView: View {
    
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
            
            NavigationLink(destination: PWMOscillatorView()){
                Text("Tap here to Play with Pulse Waveform").foregroundColor(.red).font(Font.body.bold())
            }.padding()
        }
        .padding(.horizontal, 40)
    }
}
