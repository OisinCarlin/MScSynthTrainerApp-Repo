//
//  SoundWavesTutorial.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 22/07/2022.
//
// Sound Waves Tutorial TabView Slideshow
//


import SwiftUI
import SwiftUI
import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import SwiftUI
import AudioToolbox

struct SoundWavesTutorial: View {
    var body: some View {
        TabView{
            OnboardView(systemImageName1: "fly",
                        systemImageName2: "speaker",
                        title: "Good Vibrations",
                        description: "Sound is made when things vibrate, for example a fly flapping its wings or a speaker moving in and out. The faster the fly flaps its wings or the speaker moves, the higher pitch of the sound. The slower the vibrations, the lower the pitch.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.orange, width: 16)
            OnboardViewOneImage(systemImageName1: "wave",
                                title: "Waves",
                                description: "When a speaker pushes out and pulls back, or when a fly moves its wings up and down it makes waves in the air - just like the wind pushes and pulls the water to make waves in the sea.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.orange, width: 16)
            OnboardViewOneImage(systemImageName1: "soundWaveEar",
                                title: "Waves",
                                description: "These waves travel through the air to your eardrum and vibrate it so you hear the sound. Whether the speaker is pushing or pulling at a certain time can be represented by a 'waveform' as shown in the picture.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.orange, width: 16)
            SWPitchLinkView(systemImageName1: "highLowFreq",
                            title: "Frequency",
                            description: "Let's have another look at the 'pitch' or 'frequency' of a sound. The waves of higher pitched sounds move more quickly, or 'frequently' over time than lower pitched sounds - and a speaker making a higher pitched sound would move faster. Play with pitch again and watch how the waves move on the screen.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.orange, width: 16)
            SWAmplitudeLinkView(systemImageName1: "quietLoud",
                                title: "Amplitude",
                                description: "Let's have another look at the 'amplitude' of a sound. The waves of louder sounds move further up and down than quieter sounds. This means a speaker would push and pull the air harder to make a louder sound. Play with amplitude again and watch how the waves move.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.orange, width: 16)
            
        }
        .tabViewStyle(PageTabViewStyle())
        
        // To display page dots on bottom of view
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        
    }
}

struct SoundWavesTutorial_Previews: PreviewProvider {
    static var previews: some View {
        SoundWavesTutorial()
    }
}
