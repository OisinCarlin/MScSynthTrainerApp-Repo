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
            OnboardViewOneImage(systemImageName1: "envelope",
                                title: "ADSR Envelopes",
                                description: "ADSR Envelopes are a way to change synthesiser controls and sounds over time. Different synth controls that can be changed or 'modulated' by envelopes, but here we will be changing amplitude over time after pressing a keyboard key. This can give the sounds you make a surprising amount of character, from short, sharp sounds to long, droning sounds. ADSR stands for the four parts of the envelope: Attack, Decay, Sustain and Release.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.blue, width: 16)
            
            OnboardView(systemImageName1: "pianoKey",
                        systemImageName2: "celloBow",
                        title: "Attack",
                        description: "'Attack' is the first part of the ADSR envelope. When controlling Amplitude, it is the amount of time it takes for a sound to reach the maximum amplitude. This can be thought of how it 'attacks' the note. A piano has a short attack time - the note is its loudest immediately upon pressing the key. A bowed cello may have a longer attack time - once bowing begins the note gradually gets louder until it hits a peak amplitude (before it begins to decay).")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.blue, width: 16)
            OnboardView(systemImageName1: "pianoKey",
                        systemImageName2: "triangle",
                        title: "Decay",
                        description: "'Decay' is the second part of the ADSR envelope. When controlling Amplitude, it is the amount of time it takes for a sound after reaching the peak amplitude to 'decay', or reduce the amplitude to a lower level which may be sustained. Think of pressing and holding a piano key, or striking a triangle. Decay is the time it takes for the amplitude to reduce from the initial strike, or 'attack' for the sound to reach a lower amplitude which may ring out, or 'sustain'.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.blue, width: 16)
            OnboardView(systemImageName1: "acousticGuitar",
                        systemImageName2: "electricGuitar",
                        title: "Sustain",
                        description: "'Sustain' is the third part of the ADSR envelope. Unlike all the other parts, it is not a time. When controlling amplitude with the envelope - it is amplitude level during the main sequence of the sound which is 'sustained' after the peak and following the decay. Think of an acoustic guitar and an electric guitar through a distorted amplifier. A note held on the acoustic guitar decay to a lower sustain level compared to the initial pluck, while the distortion on the electric guitar can make the note 'ring' louder.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.blue, width: 16)
            OnboardView(systemImageName1: "pianoKey",
                        systemImageName2: "celloBow",
                        title: "Release",
                        description: "'Release' is the last part of the ADSR envelope. It is the amount of time after a note is let go for the amplitude to fade away from the 'sustain' level to zero. Think again of the piano. The note can be pressed, held and sustained, but when the note is released it quickly stops. This is because it has a short release time. A cello may have a longer release time if you stop bowing but still hold the note on the neck - the note gradually fades away.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.blue, width: 16)
//            OnboardViewOneImage(systemImageName1: "",
//                                title: "",
//                                description: "")
            
            
            //: * Sustain is not a time, but a percentage of the peak amplitude that will be the the sustained amplitude.
            //: * Release is the amount of time after a note is let go for the sound to die away to zero.

            
            //: * Attack is the amount of time it takes a sound to reach its maximum volume.  An example of a fast attack is a
            //:   piano, where as a cello can have a longer attack time.
            
            AmpEnvLinkView(systemImageName1: "appADSR",
                           title: "Play with ADSR Envelope",
                           description: "This is the ADSR Envelope which will control the amplitude of the sound produced by the oscillator on our synth. There is also a 'master amplitude' which will turn the volume of the overall sound up and or down. The red 'attack' slope, the orange 'decay' slope and purple 'release' slope can be dragged left or right to change the length of time for each of these parts of the envelope. The green 'sustain' level can be changed by dragging up or down. Press and hold a keyboard key, then let go after a while to hear the effect of the Amplitude Envelope on the oscillator sound.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.blue, width: 16)
            
            FiltersAmpEnvLinkView(systemImageName1: "appADSR",
                           title: "Play ADSR Enveloped Sound through Filters",
                           description: "Now that you have had a go at using an ADSR envelope to control the amplitude of synth oscillator sounds - try playing some enveloped sounds through some of the filters you've learned to see what interesting sounds you can create.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.blue, width: 16)
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
