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


struct OscillatorsAndWaveformsTutorial: View {
    var body: some View {
        TabView{
            OWOnboardView(systemImageName1: "fly",
                        systemImageName2: "speaker",
                        title: "Good Vibrations",
                        description: "Sound is made when things vibrate, for example a fly flapping its wings or a speaker moving in and out. The faster the fly flaps its wings or the speaker moves, the higher pitch of the sound. The slower the vibrations, the lower the pitch.")
            OWOnboardViewOneImage(systemImageName1: "wave",
                        title: "Waves",
                        description: "When a speaker pushes out and pulls back, or when a fly moves its wings up and down it makes waves in the air - just like the wind pushes and pulls the water to make waves in the sea.")
            OWOnboardViewOneImage(systemImageName1: "soundWaveEar",
                        title: "Waves",
                        description: "These waves travel through the air to your eardrum and vibrate it so you hear the sound. Whether the speaker is pushing or pulling at a certain time can be represented by a 'waveform' as shown in the picture.")
            OWOnboardViewOneImage(systemImageName1: "highLowFreq",
                        title: "Frequency",
                        description: "Let's have another look at the 'pitch' or 'frequency' of a sound. The waves of higher pitched sounds move more quickly, or 'frequently' over time than lower pitched sounds - and a speaker making a higher pitched sound would move faster. Play with pitch again and watch how the waves move on the screen.")
            BasicControlsPitchOscillatorView()
            OWOnboardViewOneImage(systemImageName1: "quietLoud",
                        title: "Amplitude",
                        description: "Let's have another look at the 'amplitude' of a sound. The waves of louder sounds move further up and down than quieter sounds. This means a speaker would push and pull the air harder to make a louder sound. Play with amplitude again and watch how the waves moBasicControlsAmplitudeOscillatorView()")

            BasicControlsAmplitudeOscillatorView()
        }
        .tabViewStyle(PageTabViewStyle())
        
        // To display page dots on bottom of view
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OWOnboardView: View {
    
    let systemImageName1: String
    let systemImageName2: String
    let title: String
    let description: String
    
    var body: some View {
        
        VStack(spacing: 20){
            HStack{
                Image(systemImageName1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                Image(systemImageName2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
            }

            
            Text(title)
                .font(.title).bold()
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 40)
    }
}

struct OWOnboardViewOneImage: View {
    
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
        }
        .padding(.horizontal, 40)
    }
}

// **************** Oscillator Data *****************************


struct OWOscillatorData {
    var isPlaying: Bool = false
    var frequency: AUValue = 440
    var amplitude: AUValue = 0.1
    var rampDuration: AUValue = 0.01
}

class OWOscillatorConductor: ObservableObject, KeyboardDelegate {

    let engine = AudioEngine()

    func noteOn(note: MIDINoteNumber) {
        data.isPlaying = true
        data.frequency = note.midiNoteToFrequency()
    }

    func noteOff(note: MIDINoteNumber) {
        data.isPlaying = false
    }

    @Published var data = BasicControlsOscillatorData() {
        didSet {
            if data.isPlaying {
                osc.start()
                osc.$frequency.ramp(to: data.frequency, duration: data.rampDuration)
                osc.$amplitude.ramp(to: data.amplitude, duration: data.rampDuration)
            } else {
                osc.amplitude = 0.0
            }
        }
    }

    var osc = Oscillator()

    init() {
        engine.output = osc
    }

    func start() {
        osc.amplitude = 0.2
        do {
            try engine.start()
        } catch let err {
            Log(err)
        }
    }

    func stop() {
        data.isPlaying = false
        osc.stop()
        engine.stop()
    }
}

struct OWOscillatorView: View {
    @StateObject var conductor = BasicControlsOscillatorConductor()

    var body: some View {
        VStack {
            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }
//            ParameterSlider(text: "Frequency",
//                            parameter: self.$conductor.data.frequency,
//                            range: 220...880).padding()
            ParameterSlider(text: "Amplitude",
                            parameter: self.$conductor.data.amplitude,
                            range: 0 ... 1).padding()
//            ParameterSlider(text: "Ramp Duration",
//                            parameter: self.$conductor.data.rampDuration,
//                            range: 0...10).padding()
            NodeOutputView(conductor.osc)
//            KeyboardControl(firstOctave: 0,
//                            octaveCount: 2,
//                            polyphonicMode: false,
//                            delegate: conductor)

        }.cookbookNavBarTitle("Play with Amplitude")
        .onAppear {
            self.conductor.start()
        }
        .onDisappear {
            self.conductor.stop()
        }
    }
}


struct OscillatorsAndWaveformsTutorial_Previews: PreviewProvider {
    static var previews: some View {
        OscillatorsAndWaveformsTutorial()
    }
}
