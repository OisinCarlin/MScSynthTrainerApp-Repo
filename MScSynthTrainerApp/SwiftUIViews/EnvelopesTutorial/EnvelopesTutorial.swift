//
//  EnvelopesTutorial.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 09/08/2022.
//

import SwiftUI

struct EnvelopesTutorial: View {
    var body: some View {
        TabView{
            AmpEnvLinkView(systemImageName1: "envelope",
                           title: "Amplitude Envelope",
                           description: "")
            LPFAmpEnvLinkView(systemImageName1: "envelope",
                           title: "LPF and Amplitude Envelope",
                           description: "")

        }
        
        
        .tabViewStyle(PageTabViewStyle())
        
        // To display page dots on bottom of view
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}


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
                    .frame(width: 400, height: 300)
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

struct LPFAmpEnvLinkView: View {
    
    let systemImageName1: String
    let title: String
    let description: String
    
    
    var body: some View {
        
        VStack(spacing: 20){
            HStack{
                Image(systemImageName1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 300)
                    .foregroundColor(.blue)
                
            }
            
            
            Text(title)
                .font(.title).bold()
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            NavigationLink(destination: LPFAmpEnvView()){
                Text("Tap here to Play with Amplitude Envelope through Low Pass Filter").foregroundColor(.red).font(Font.body.bold())
            }.padding()
        }
        .padding(.horizontal, 40)
    }
}

struct EnvelopesTutorial_Previews: PreviewProvider {
    static var previews: some View {
        EnvelopesTutorial()
    }
}
