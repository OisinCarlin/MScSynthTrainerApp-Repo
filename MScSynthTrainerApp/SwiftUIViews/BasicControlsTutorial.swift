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
                        description: "Some synths have musical keyboards as a control for the pitch of sounds, or 'notes' they make. The pitch is 'lower' the further left of the keyboard and 'higher' the further right. A sound is played when a key is pressed and stops when the key is released.")
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

struct OnboardView: View {
    
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

// **************** Oscillator Data *****************************


struct BasicControlsOscillatorData {
    var isPlaying: Bool = false
    var frequency: AUValue = 440
    var amplitude: AUValue = 0.1
    var rampDuration: AUValue = 0.01
}

class BasicControlsOscillatorConductor: ObservableObject, KeyboardDelegate {

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

struct BasicControlsAmplitudeOscillatorView: View {
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

struct BasicControlsPitchOscillatorView: View {
    @StateObject var conductor = BasicControlsOscillatorConductor()

    var body: some View {
        VStack {
            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }
            ParameterSlider(text: "Frequency",
                            parameter: self.$conductor.data.frequency,
                            range: 220...880).padding()
//            ParameterSlider(text: "Amplitude",
//                            parameter: self.$conductor.data.amplitude,
//                            range: 0 ... 1).padding()
//            ParameterSlider(text: "Ramp Duration",
//                            parameter: self.$conductor.data.rampDuration,
//                            range: 0...10).padding()
            NodeOutputView(conductor.osc)
//            KeyboardControl(firstOctave: 0,
//                            octaveCount: 2,
//                            polyphonicMode: false,
//                            delegate: conductor)

        }.cookbookNavBarTitle("Play with Pitch")
        .onAppear {
            self.conductor.start()
        }
        .onDisappear {
            self.conductor.stop()
        }
    }
}

struct BasicControlsKeyboardOscillatorView: View {
    @StateObject var conductor = BasicControlsOscillatorConductor()

    var body: some View {
        VStack {
//            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
//                self.conductor.data.isPlaying.toggle()
//            }
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
            KeyboardControl(firstOctave: 3,
                            octaveCount: 2,
                            polyphonicMode: false,
                            delegate: conductor)

        }.cookbookNavBarTitle("Play using the keyboard")
        .onAppear {
            self.conductor.start()
        }
        .onDisappear {
            self.conductor.stop()
        }
    }
}

struct BasicControlsGlideOscillatorView: View {
    @StateObject var conductor = BasicControlsOscillatorConductor()

    var body: some View {
        VStack {
//            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
//                self.conductor.data.isPlaying.toggle()
//            }
//            ParameterSlider(text: "Frequency",
//                            parameter: self.$conductor.data.frequency,
//                            range: 220...880).padding()
            ParameterSlider(text: "Amplitude",
                            parameter: self.$conductor.data.amplitude,
                            range: 0 ... 1).padding()
            ParameterSlider(text: "Glide Time",
                            parameter: self.$conductor.data.rampDuration,
                            range: 0...10).padding()
            NodeOutputView(conductor.osc)
            KeyboardControl(firstOctave: 3,
                            octaveCount: 2,
                            polyphonicMode: false,
                            delegate: conductor)

        }.cookbookNavBarTitle("Play with Glide")
        .onAppear {
            self.conductor.start()
        }
        .onDisappear {
            self.conductor.stop()
        }
    }
}

struct BasicControlsOscillatorView_Previews: PreviewProvider {
    static var previews: some View {
        OscillatorView()
    }
}

// *************End of Oscillator Data **************************
