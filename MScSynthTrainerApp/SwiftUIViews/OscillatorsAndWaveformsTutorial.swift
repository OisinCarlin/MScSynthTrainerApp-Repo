//
//  OscillatorsAndWaveformsTutorial.swift
//  MScSynthTrainerApp

// Ref: learningsynths.ableton.com/en/oscillators/how-synths-make-sound
//
// Possibly separate into Sound Waves and Oscillators/Waveforms sections of tutorials
//
//  Created by Oisin Carlin on 21/07/2022.
//

// Talk about square/pulse wave modulation
// Possibly after the last waveform show or as part of the square wave



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
            OnboardViewOneImage(systemImageName1: "vco",
                        title: "Oscillators",
                        description: "'Oscillators' (or 'VCOs') are the parts of synths that make sounds from different waveforms you can choose. Other synth parts can then sculpt these basic sounds into more interesting sounds. There may be one or more oscillators on a synth which you can combine or turn on and off.")
            OnboardViewOneImage(systemImageName1: "sineWave",
                        title: "Sine Waveform",
                        description: "Sine waves are smooth, curved waves that do not have any corners or sharp drops. They make smooth, clear whistling or vocal-like sounds. Because of their cleanness or lack of a 'grit' you may find in other waveforms, it may be harder to hear lower-pitched sine-wave tones through smaller speakers.")
            OWSineOscillatorView()
            OnboardViewOneImage(systemImageName1: "triangleWave",
                        title: "Triangle Waveform",
                        description: "Triangle waves are like sine wave but with corners instead of curves - making them triangle shaped. They sound not as smooth but a bit clearer and brighter than a sine wave. Instead of a person whistling a triangle-wave tone might remind you of a recorder or a flute.")
            OWTriangleOscillatorView()
            OnboardViewOneImage(systemImageName1: "sawWave",
                        title: "Sawtooth Waveform",
                        description: "Sawtooth waves are jagged shaped like the teeth of a saw. The waves rise up a slope then sharply drop down with tight corners. This makes them very rich and buzzy sounding. You can imagine a sawtooth-like tone being made by a violin or cello - the bow pulls the string out and then it quickly snaps back before being pulled again.")
            OWSawtoothOscillatorView()
            OnboardViewOneImage(systemImageName1: "squareWave",
                        title: "Square (Pulse) Waveform",
                        description: "Square waves are a type of evenly shaped 'Pulse' waveform (other pulse waves have bigger then smaller rectangle shapes). Nearly all the waves's cycle is spent at the very top or bottom with sharp drops between. This makes sound quite buzzy like the sawtooth waveform - but the space between the waves makes them sound quite hollow. Think of woodwind instruments like clarinets.")
            OWSquareOscillatorView()
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
            }
//                        HStack {
//                            Spacer()
//                            Text("Sine").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.sine))
//                            }
//                            Spacer()
//                            Text("Square").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.square))
//                            }
//                            Spacer()
//                            Text("Triangle").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.triangle))
//                            }
//                            Spacer()
//                            Text("Sawtooth").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.sawtooth))
//                            }
//                            Spacer()
//                        }
            
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
                
            }
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
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
            }
//                        HStack {
//                            Spacer()
//                            Text("Sine").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.sine))
//                            }
//                            Spacer()
//                            Text("Square").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.square))
//                            }
//                            Spacer()
//                            Text("Triangle").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.triangle))
//                            }
//                            Spacer()
//                            Text("Sawtooth").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.sawtooth))
//                            }
//                            Spacer()
//                        }
            
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
                
            }
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
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
            }
//                        HStack {
//                            Spacer()
//                            Text("Sine").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.sine))
//                            }
//                            Spacer()
//                            Text("Square").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.square))
//                            }
//                            Spacer()
//                            Text("Triangle").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.triangle))
//                            }
//                            Spacer()
//                            Text("Sawtooth").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.sawtooth))
//                            }
//                            Spacer()
//                        }
            
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
                
            }
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
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
            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
                self.conductor.data.isPlaying.toggle()
                
                // Do on show/hide keyboard also
                self.conductor.osc.setWaveform(Table(.square))
            }
//                        HStack {
//                            Spacer()
//                            Text("Sine").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.sine))
//                            }
//                            Spacer()
//                            Text("Square").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.square))
//                            }
//                            Spacer()
//                            Text("Triangle").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.triangle))
//                            }
//                            Spacer()
//                            Text("Sawtooth").onTapGesture {
//                                self.conductor.osc.setWaveform(Table(.sawtooth))
//                            }
//                            Spacer()
//                        }
            
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
                
            }
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
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

struct OWOscillatorView: View {
    @StateObject var conductor = OscillatorConductor()
    
    var body: some View {
        VStack {
            
//            if(self.conductor.data.showKeyboard == false){
            Text(self.conductor.data.isPlaying ? "Pause" : "Play").onTapGesture {
                self.conductor.data.isPlaying.toggle()
//            }
                // Do on show/hide keyboard also
//                self.conductor.osc.setWaveform(Table(.triangle))
            }
            
            
            
            
            
                        HStack {
                            Spacer()
                            Text("Sine").onTapGesture {
                                self.conductor.osc.setWaveform(Table(.sine))
                            }
                            Spacer()
                            Text("Square").onTapGesture {
                                self.conductor.osc.setWaveform(Table(.square))
                            }
                            Spacer()
                            Text("Triangle").onTapGesture {
                                self.conductor.osc.setWaveform(Table(.triangle))
                            }
                            Spacer()
                            Text("Sawtooth").onTapGesture {
                                self.conductor.osc.setWaveform(Table(.sawtooth))
                            }
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
            }
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                KeyboardControl(firstOctave: 3,
                                octaveCount: 2,
                                polyphonicMode: false,
                                delegate: conductor)
            }
        }.cookbookNavBarTitle("Oscillator")
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
