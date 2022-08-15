//
//  FiltersTutorial.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 03/08/2022.
//

import SwiftUI

struct FiltersTutorial: View {
    var body: some View {
        TabView{
            OnboardViewOneImage(systemImageName1: "hearingRange",
                                title: "Hearing Range",
                                description: "Humans can hear sound frequencies from 20 Hz (20 wave cycles per second) to 20,000 Hz, or 20 kHZ. Some animals, like whales, can hear sounds lower pitched than humans can hear. Others animals, like dogs (which can hear dog whistles) can hear sounds higher pitched than humans. All sounds you hear fall within this range and each individual sound is made up of a range of low and high frequencies.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.green, width: 16)
            
            OnboardViewOneImage(systemImageName1: "doorOpenClose",
                                title: "Real World Sound Filters",
                                description: "Think of loud music playing in another room, then closing the door. The music will sound muffled and 'darker', and the bass will be noticable. This is because the door is 'filtering' out the higher, 'brighter' frequencies of the music and letting the lower frequencies through.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.green, width: 16)
            OnboardViewOneImage(systemImageName1: "coffeeFilter",
                                title: "Filters in Music and Synths",
                                description: "Electronic sound filters are often found on synthesisers and other music equipment. They can be used to reduce frequencies of a sounds that are undesired. Filters can help shape basic sounds, like the oscillator waveforms you have heard, into more interesting sounds. Think of a coffee filter - you want to drink the liquid coffee, but not the coffee grounds!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.green, width: 16)
            OnboardViewOneImage(systemImageName1: "LPFruityEQ",
                                title: "Cut-off Frequency",
                                description: "Cut-off Frequency is one of the controls of a sound filter on a synth. It is the point in the Frequency Spectrum (range of human hearing) that you want to start removing frequencies beyond that point. This is what a sound filter imitating the door may look like. The purple point on the spectrum where the sound (orange) is starting to be filtered is the Cutoff Frequency.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.green, width: 16)
            OnboardViewOneImage(systemImageName1: "resonance",
                                title: "Resonance",
                                description: "Another control often found on sound filters on synths is resonance. Resonance increases frequencies around the Cut-off point, making those frequencies louder, or 'resonate'. When moving the Cut-off point on a more resonant filter, this can make a noticible 'sweeping' effect.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.green, width: 16)
            LPFLinkView(systemImageName1: "lowPassFilter",
                        title: "Low Pass Filter",
                        description: "There are diffent filter types you can choose when using a sound filter on a synth.  A 'Low-Pass' filter behaves just like a door does when loud music is playing in the other room. It allows lower (darker) frequencies below the Cut-off point to pass through the filter, and takes away the higher (brighter) frequencies above the Cut-off point.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.green, width: 16)
            HPFLinkView(systemImageName1: "highPassFilter",
                        title: "High Pass Filter",
                        description: "Another filter type you may find on synths is the 'High-pass' filter. They are the opposite of the Low-pass filter. High-pass filters allow the higher freqencies of a sound above the Cut-off point to pass through the filter, and reduce lower frequencies below the Cut-off point.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.green, width: 16)
            BPFLinkView(systemImageName1: "bandPassFilter",
                        title: "Band Pass Filter",
                        description: "'Band-pass' filters allow a band of frequencies to pass through the filter, taking away frequencies at either end of the band. The 'bandwidth' is the width of the band of frequencies allowed through the filter. Instead of a Cut-off frequency, the center frequency controls the position of the middle of the band.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.green, width: 16)
            BRFLinkView(systemImageName1: "bandRejectFilter",
                        title: "Band Reject Filter",
                        description: "'Band Reject' filters are the opposite of the 'Band-pass' filter. They reject frequencies between the band and allow frequencies at either end of the band to pass through. Again, the 'bandwidth' is the width of the band of frequencies rejected by the filter, and the center frequency controls the position of the middle of the band.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.green, width: 16)
        }
        
        
        .tabViewStyle(PageTabViewStyle())
        
        // To display page dots on bottom of view
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}


struct FiltersTutorial_Previews: PreviewProvider {
    static var previews: some View {
        FiltersTutorial()
    }
}
