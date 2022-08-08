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
//            OnboardViewOneImage(systemImageName1: "vco",
//                        title: "Oscillators",
//                        description: "'Oscillators' (or 'VCOs') are the parts of synths that make sounds from different waveforms you can choose. Other synth parts can then sculpt these basic sounds into more interesting sounds. There may be one or more oscillators on a synth which you can combine or turn on and off.")
            OWSineLinkView(systemImageName1: "sineWave",
                        title: "Sine Waveform",
                        description: "Sine waves are smooth, curved waves that do not have any corners or sharp drops. They make smooth, clear whistling or vocal-like sounds. Because of their cleanness or lack of a 'grit' you may find in other waveforms, it may be harder to hear lower-pitched sine-wave tones through smaller speakers.")
//            OWSineOscillatorView()
            OWTriangleLinkView(systemImageName1: "triangleWave",
                        title: "Triangle Waveform",
                        description: "Triangle waves are like sine wave but with corners instead of curves - making them triangle shaped. They sound not as smooth but a bit clearer and brighter than a sine wave. Instead of a person whistling a triangle-wave tone might remind you of a recorder or a flute.")
//            OWTriangleOscillatorView()
            OWSawtoothLinkView(systemImageName1: "sawWave",
                        title: "Sawtooth Waveform",
                        description: "Sawtooth waves are jagged shaped like the teeth of a saw. The waves rise up a slope then sharply drop down with tight corners. This makes them very rich and buzzy sounding. You can imagine a sawtooth-like tone being made by a violin or cello - the bow pulls the string out and then it quickly snaps back before being pulled again.")
//            OWSawtoothOscillatorView()
            OWSquareLinkView(systemImageName1: "squareWave",
                        title: "Square Waveform",
                        description: "Square waves are a type of evenly sized 'Pulse' waveform in the shape of a square. Nearly all the waves's cycle is spent at the very top or bottom with sharp drops between. This makes the sound quite buzzy, but the space between the waves makes them sound quite hollow. Think of woodwind instruments like clarinets, or old video game sounds.")
            OWPWMLinkView(systemImageName1: "pwm",
                        title: "Pulse Waveform",
                        description: "Pulse waveforms look similar to square waveforms and sound similarly buzzy and hollow, but alternate between wider and narrower rectangle shapes. The width of these waves can be changed though 'Pulse-width modulation' (PWM). If the waves have the same width - they are 'square waves'. Changing the width affects the character of the sound.")
            OWVCOLinkView(systemImageName1: "vco",
                        title: "Oscillators",
                        description: "'Oscillators' (or 'VCOs') are the parts of synths that make sounds from different waveforms you can choose. Other synth parts can then sculpt these basic sounds into more interesting sounds. We will now attatch the Oscillator controls to the synth so you can play with the different waveforms you have learned about.")
            
//            OWSquareOscillatorView()
        }
        .tabViewStyle(PageTabViewStyle())
        
        // To display page dots on bottom of view
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

// **************** Oscillator Data *****************************


struct OWOscillatorData {
    var isPlaying: Bool = false
    var frequency: AUValue = 440
    var amplitude: AUValue = 0.1
    var rampDuration: AUValue = 0.01
    
    var showKeyboard = false
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
    
    @Published var data = OscillatorData() {
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

struct OWSineOscillatorView: View {
    @StateObject var conductor = OscillatorConductor()
    
    var body: some View {
        VStack {
            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
                self.conductor.data.isPlaying.toggle()
                
                // Do on show/hide keyboard also
                self.conductor.osc.setWaveform(Table(.sine))
            }.foregroundColor(.green).font(Font.body.bold())

            if(self.conductor.data.showKeyboard == false){
                ParameterSlider(text: "Frequency",
                                parameter: self.$conductor.data.frequency,
                                range: 20...880).padding()
            }
            
            ParameterSlider(text: "Amplitude",
                            parameter: self.$conductor.data.amplitude,
                            range: 0 ... 1).padding()
                        ParameterSlider(text: "Glide",
                                        parameter: self.$conductor.data.rampDuration,
                                        range: 0...10).padding()
            
            //Show Keyboard button
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
                
                self.conductor.osc.setWaveform(Table(.sine))
                
            }.foregroundColor(.red).font(Font.body.bold())

            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                Text("Hold key to hold the note")
                KeyboardControl(firstOctave: 3,
                                octaveCount: 2,
                                polyphonicMode: false,
                                delegate: conductor)
            }
        }.cookbookNavBarTitle("Play Sine Wave")
            .onAppear {
                self.conductor.start()
            }
            .onDisappear {
                self.conductor.stop()
            }
    }
}

struct OWTriangleOscillatorView: View {
    @StateObject var conductor = OscillatorConductor()
    
    var body: some View {
        VStack {
            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
                self.conductor.data.isPlaying.toggle()
                
                // Do on show/hide keyboard also
                self.conductor.osc.setWaveform(Table(.triangle))
            }.foregroundColor(.green).font(Font.body.bold())
            
            if(self.conductor.data.showKeyboard == false){
                ParameterSlider(text: "Frequency",
                                parameter: self.$conductor.data.frequency,
                                range: 20...880).padding()
            }
            
            ParameterSlider(text: "Amplitude",
                            parameter: self.$conductor.data.amplitude,
                            range: 0 ... 1).padding()
                        ParameterSlider(text: "Glide",
                                        parameter: self.$conductor.data.rampDuration,
                                        range: 0...10).padding()
            
            //Show Keyboard button
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
                
                self.conductor.osc.setWaveform(Table(.triangle))
                
            }.foregroundColor(.red).font(Font.body.bold())
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                Text("Hold key to hold the note")
                KeyboardControl(firstOctave: 3,
                                octaveCount: 2,
                                polyphonicMode: false,
                                delegate: conductor)
            }
        }.cookbookNavBarTitle("Play Triangle Wave")
            .onAppear {
                self.conductor.start()
            }
            .onDisappear {
                self.conductor.stop()
            }
    }
    
}

struct OWSawtoothOscillatorView: View {
    @StateObject var conductor = OscillatorConductor()
    
    var body: some View {
        VStack {
            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
                self.conductor.data.isPlaying.toggle()
                
                // Do on show/hide keyboard also
                self.conductor.osc.setWaveform(Table(.sawtooth))
            }.foregroundColor(.green).font(Font.body.bold())

            
            if(self.conductor.data.showKeyboard == false){
                ParameterSlider(text: "Frequency",
                                parameter: self.$conductor.data.frequency,
                                range: 20...880).padding()
            }
            
            ParameterSlider(text: "Amplitude",
                            parameter: self.$conductor.data.amplitude,
                            range: 0 ... 1).padding()
                        ParameterSlider(text: "Glide",
                                        parameter: self.$conductor.data.rampDuration,
                                        range: 0...10).padding()
            
            //Show Keyboard button
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
                
                self.conductor.osc.setWaveform(Table(.sawtooth))
                
            }.foregroundColor(.red).font(Font.body.bold())
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                Text("Hold key to hold the note")
                KeyboardControl(firstOctave: 3,
                                octaveCount: 2,
                                polyphonicMode: false,
                                delegate: conductor)
            }
        }.cookbookNavBarTitle("Play Sawtooth Wave")
            .onAppear {
                self.conductor.start()
            }
            .onDisappear {
                self.conductor.stop()
            }
    }
    
}

struct OWSquareOscillatorView: View {
    @StateObject var conductor = OscillatorConductor()
    
    var body: some View {
        VStack {
//            NavigationLink(destination: OWOscillatorView()){
//                Text("Show all waveforms").foregroundColor(.purple).font(Font.body.bold())
//            }.padding()
            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
                self.conductor.data.isPlaying.toggle()
                
                // Do on show/hide keyboard also
                self.conductor.osc.setWaveform(Table(.square))
            }.foregroundColor(.green).font(Font.body.bold())

            
            if(self.conductor.data.showKeyboard == false){
                ParameterSlider(text: "Frequency",
                                parameter: self.$conductor.data.frequency,
                                range: 20...880).padding()
            }
            
            ParameterSlider(text: "Amplitude",
                            parameter: self.$conductor.data.amplitude,
                            range: 0 ... 1).padding()
                        ParameterSlider(text: "Glide",
                                        parameter: self.$conductor.data.rampDuration,
                                        range: 0...10).padding()
            
            //Show Keyboard button
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
                
                self.conductor.osc.setWaveform(Table(.square))
                
            }.foregroundColor(.red).font(Font.body.bold())
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                Text("Hold key to hold the note")
                KeyboardControl(firstOctave: 3,
                                octaveCount: 2,
                                polyphonicMode: false,
                                delegate: conductor)
            }
        }.cookbookNavBarTitle("Play Square Wave")
            .onAppear {
                self.conductor.start()
            }
            .onDisappear {
                self.conductor.stop()
            }
    }
    
}

struct PWMOscillatorView: View {
    @StateObject var conductor = PWMOscillatorConductor()

    var body: some View {
        VStack {
            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(.green).font(Font.body.bold())
            ParameterSlider(text: "Pulse Width",
                            parameter: self.$conductor.data.pulseWidth,
                            range: 0 ... 1).padding(5)
            if(self.conductor.data.showKeyboard == false){
                ParameterSlider(text: "Frequency",
                                parameter: self.$conductor.data.frequency,
                                range: 20...880).padding()
            }
            ParameterSlider(text: "Amplitude",
                            parameter: self.$conductor.data.amplitude,
                            range: 0 ... 1).padding(5)
            ParameterSlider(text: "Glide",
                            parameter: self.$conductor.data.rampDuration,
                            range: 0...10).padding(5)

//            NodeOutputView(conductor.osc)
            //Show Keyboard button
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
                
//                self.conductor.osc.setWaveform(Table(.triangle))
//
            }.foregroundColor(.red).font(Font.body.bold())
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                Text("Hold key to hold the note")
                KeyboardControl(firstOctave: 3,
                                octaveCount: 2,
                                polyphonicMode: false,
                                delegate: conductor)
            }

        }.cookbookNavBarTitle("Play with Pulse Wave")
        .onAppear {
            self.conductor.start()
        }
        .onDisappear {
            self.conductor.stop()
        }
    }
}

struct OWOscillatorView: View {
    @StateObject var conductor = OscillatorConductor()
    
    @State private var didTapSine:Bool = false
    @State private var didTapSquare:Bool = false
    @State private var didTapTriangle:Bool = false
    @State private var didTapSawtooth:Bool = false
    
    var body: some View {
        VStack {
            
//            if(self.conductor.data.showKeyboard == false){
            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
                self.conductor.data.isPlaying.toggle()
//            }
                // Do on show/hide keyboard also
//                self.conductor.osc.setWaveform(Table(.triangle))
            }.foregroundColor(.green).font(Font.body.bold())
            
            
            
            
            
            HStack {
                Spacer()
                Text("Sine").onTapGesture {
                    self.conductor.osc.setWaveform(Table(.sine))
                    
                    self.didTapSine = true
                    self.didTapSquare = false
                    self.didTapTriangle = false
                    self.didTapSawtooth = false
                }
                .foregroundColor(didTapSine ? Color.red : Color.black).font(Font.body.bold())
                Spacer()
                
                Text("Square").onTapGesture {
                    self.conductor.osc.setWaveform(Table(.square))
                    
                    self.didTapSine = false
                    self.didTapSquare = true
                    self.didTapTriangle = false
                    self.didTapSawtooth = false
                }
                .foregroundColor(didTapSquare ? Color.red : Color.black).font(Font.body.bold())
                Spacer()
                
                Text("Triangle").onTapGesture {
                    self.conductor.osc.setWaveform(Table(.triangle))
                    
                    self.didTapSine = false
                    self.didTapSquare = false
                    self.didTapTriangle = true
                    self.didTapSawtooth = false
                }                .foregroundColor(didTapTriangle ? Color.red : Color.black).font(Font.body.bold())
                Spacer()
                
                Text("Sawtooth").onTapGesture {
                    self.conductor.osc.setWaveform(Table(.sawtooth))
                    
                    self.didTapSine = false
                    self.didTapSquare = false
                    self.didTapTriangle = false
                    self.didTapSawtooth = true
                }                .foregroundColor(didTapSawtooth ? Color.red : Color.black).font(Font.body.bold())
//                Spacer()
                NavigationLink(destination: PWMOscillatorView()){
                    Text("Pulse").foregroundColor(.purple).font(Font.body.bold())
                }.padding()
                Spacer()
                
            }
            
            
            
            
            
            if(self.conductor.data.showKeyboard == false){
                ParameterSlider(text: "Frequency",
                                parameter: self.$conductor.data.frequency,
                                range: 20...880).padding()
            }
            
            ParameterSlider(text: "Amplitude",
                            parameter: self.$conductor.data.amplitude,
                            range: 0 ... 1).padding()
                        ParameterSlider(text: "Glide",
                                        parameter: self.$conductor.data.rampDuration,
                                        range: 0...10).padding()
            
            //Show Keyboard button
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
                
//                self.conductor.osc.setWaveform(Table(.triangle))
//
            }.foregroundColor(.red).font(Font.body.bold())
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                Text("Hold key to hold the note")
                KeyboardControl(firstOctave: 3,
                                octaveCount: 2,
                                polyphonicMode: false,
                                delegate: conductor)
            }
        }.cookbookNavBarTitle("Oscillator Waveforms")
            .onAppear {
                self.conductor.start()
                
                self.didTapSine = true
                self.didTapSquare = false
                self.didTapTriangle = false
                self.didTapSawtooth = false
            }
            .onDisappear {
                self.conductor.stop()
            }
    }
}
// *********** Link Views *****************************


struct OWSineLinkView: View {
    
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
            
            NavigationLink(destination: OWSineOscillatorView()){
                Text("Tap here to Play with Sine Waveform").foregroundColor(.red).font(Font.body.bold())
            }.padding()
        }
        .padding(.horizontal, 40)
    }
}

struct OWSquareLinkView: View {
    
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
            
            NavigationLink(destination: OWSquareOscillatorView()){
                Text("Tap here to Play with Square Waveform").foregroundColor(.red).font(Font.body.bold())
            }.padding()
        }
        .padding(.horizontal, 40)
    }
}

struct OWTriangleLinkView: View {
    
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
            
            NavigationLink(destination: OWTriangleOscillatorView()){
                Text("Tap here to Play with Triangle Waveform").foregroundColor(.red).font(Font.body.bold())
            }.padding()
        }
        .padding(.horizontal, 40)
    }
}

struct OWSawtoothLinkView: View {
    
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
            
            NavigationLink(destination: OWSawtoothOscillatorView()){
                Text("Tap here to Play with Sawtooth Waveform").foregroundColor(.red).font(Font.body.bold())
            }.padding()
        }
        .padding(.horizontal, 40)
    }
}

struct OWPWMLinkView: View {
    
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
            
            NavigationLink(destination: PWMOscillatorView()){
                Text("Tap here to Play with Pulse Waveform").foregroundColor(.red).font(Font.body.bold())
            }.padding()
        }
        .padding(.horizontal, 40)
    }
}

struct OWVCOLinkView: View {
    
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
            
            NavigationLink(destination: OWOscillatorView()){
                Text("Tap here to Play with all Oscillator Waveforms").foregroundColor(.red).font(Font.body.bold())
            }.padding()
        }
        .padding(.horizontal, 40)
    }
}



struct OscillatorsAndWaveformsTutorial_Previews: PreviewProvider {
    static var previews: some View {
        OscillatorsAndWaveformsTutorial()
    }
}
