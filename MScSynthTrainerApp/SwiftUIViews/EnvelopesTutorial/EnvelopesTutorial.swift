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
            HPFAmpEnvLinkView(systemImageName1: "envelope",
                           title: "HPF and Amplitude Envelope",
                           description: "")
            BPFAmpEnvLinkView(systemImageName1: "envelope",
                           title: "BPF and Amplitude Envelope",
                           description: "")
            BRFAmpEnvLinkView(systemImageName1: "envelope",
                           title: "BRF and Amplitude Envelope",
                           description: "")

        }
        
        
        .tabViewStyle(PageTabViewStyle())
        
        // To display page dots on bottom of view
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}


struct EnvelopesTutorial_Previews: PreviewProvider {
    static var previews: some View {
        EnvelopesTutorial()
    }
}
