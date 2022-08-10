//
//  BasicControlsTutorial.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 15/07/2022.
//

import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import SwiftUI
import AudioToolbox

struct BasicControlsTutorial: View {
    var body: some View {
        // Tab view for slide screens
        // Tab views in SwiftUI must have a type of style
        // Here we are just using the same view type over again
        // Don't have to though...
        //These can be 3,5, 7+ completely different views..
        // Could store all views in one file for handiness.
        TabView{
            OnboardView(systemImageName1: "mouse",
                        systemImageName2: "lion",
                        title: "Amplitude",
                        description: "'Amplitude' is a sound control you can find on most synths. It changes the volume of a sound - increasing amplitude makes sounds louder while decreasing makes them quieter.")
            BasicControlsAmplitudeOscillatorView()
            OnboardView(systemImageName1: "bassSinger",
                        systemImageName2: "sopranoSinger",
                        title: "Pitch",
                        description: "'Pitch' (or 'Frequency') is another common sound control you can find on synths. It changes how 'high' or 'low' a sound is. A lot of musical instruments or even your own voice can make high or low pitches.")
            BasicControlsPitchOscillatorView()
            OnboardView(systemImageName1: "keyboardSynth",
                        systemImageName2: "keyboardSynth2",
                        title: "Keyboards",
                        description: "Some synths have musical keyboards as a control for the pitch of sounds, or 'notes' they make. The pitch is 'lower' the further left of the keyboard and 'higher' the further right. A sound is played when a key is pressed and stops when the key is released. The octave controls let you go further up or down the keyboard, or show more or less keys.")
            BasicControlsKeyboardOscillatorView()
            OnboardView(systemImageName1: "skater",
                        systemImageName2: "trombone",
                        title: "Glide",
                        description: "'Glide' (or 'Portamento') is a control which makes the next note you play 'glide' up or down to it. The control sets the time it takes for the sound to 'glide' from one note to the next. Trombones make gliding sounds when the player moves the slider out or in while playing.")
            BasicControlsGlideOscillatorView()
        }
        .tabViewStyle(PageTabViewStyle())
        
        // To display page dots on bottom of view
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct BasicControlsTutorial_Previews: PreviewProvider {
    static var previews: some View {
        BasicControlsTutorial()
    }
}
