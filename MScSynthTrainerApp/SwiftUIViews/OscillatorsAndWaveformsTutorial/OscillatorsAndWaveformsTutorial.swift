//
//  OscillatorsAndWaveformsTutorial.swift
//  MScSynthTrainerApp

// Ref: learningsynths.ableton.com/en/oscillators/how-synths-make-sound
//
// Possibly separate into Sound Waves and Oscillators/Waveforms sections of tutorials
//
//  Created by Oisin Carlin on 21/07/2022.
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


struct OscillatorsAndWaveformsTutorial: View {
    var body: some View {
        TabView{
            OnboardViewOneImage(systemImageName1: "differentWaveforms",
                                title: "Waveforms",
                                description: "Sound waves come in many different shapes called 'waveforms'. The sounds of these waveforms have different characteristics, or 'timbres'. There are four main 'basic waveforms' you will often find when using synthesisers: sine, square, triangle and sawtooth.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.yellow, width: 16)

            OWSineLinkView(systemImageName1: "sineWave",
                           title: "Sine Waveform",
                           description: "Sine waves are smooth, curved waves that do not have any corners or sharp drops. They make smooth, clear whistling or vocal-like sounds. Because of their cleanness or lack of a 'grit' you may find in other waveforms, it may be harder to hear lower-pitched sine-wave tones through smaller speakers.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.yellow, width: 16)
            //            OWSineOscillatorView()
            OWTriangleLinkView(systemImageName1: "triangleWave",
                               title: "Triangle Waveform",
                               description: "Triangle waves are like sine wave but with corners instead of curves - making them triangle shaped. They sound not as smooth but a bit clearer and brighter than a sine wave. Instead of a person whistling a triangle-wave tone might remind you of a recorder or a flute.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.yellow, width: 16)

            OWSawtoothLinkView(systemImageName1: "sawWave",
                               title: "Sawtooth Waveform",
                               description: "Sawtooth waves are jagged shaped like the teeth of a saw. The waves rise up a slope then sharply drop down with tight corners. This makes them very rich and buzzy sounding. You can imagine a sawtooth-like tone being made by a violin or cello - the bow pulls the string out and then it quickly snaps back before being pulled again.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.yellow, width: 16)
            //            OWSawtoothOscillatorView()
            OWSquareLinkView(systemImageName1: "squareWave",
                             title: "Square Waveform",
                             description: "Square waves are a type of evenly sized 'Pulse' waveform in the shape of a square. Nearly all the waves's cycle is spent at the very top or bottom with sharp drops between. This makes the sound quite buzzy, but the space between the waves makes them sound quite hollow. Think of woodwind instruments like clarinets, or old video game sounds.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.yellow, width: 16)
            OWPWMLinkView(systemImageName1: "pwm",
                          title: "Pulse Waveform",
                          description: "Pulse waveforms look similar to square waveforms and sound similarly buzzy and hollow, but alternate between wider and narrower rectangle shapes. The width of these waves can be changed though 'Pulse-width modulation' (PWM). If the waves have the same width - they are 'square waves'. Changing the width affects the character of the sound.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.yellow, width: 16)
            OWVCOLinkView(systemImageName1: "vco",
                          title: "Oscillators",
                          description: "'Oscillators' (or 'VCOs') are the parts of synths that make sounds from different waveforms you can choose. Other synth parts can then sculpt these basic sounds into more interesting sounds. We will now attatch the Oscillator controls to the synth with Pitch and Amplitude so you can play with the different waveforms you have learned about.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.yellow, width: 16)
            

        }
        .tabViewStyle(PageTabViewStyle())
        
        // To display page dots on bottom of view
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OscillatorsAndWaveformsTutorial_Previews: PreviewProvider {
    static var previews: some View {
        OscillatorsAndWaveformsTutorial()
    }
}
