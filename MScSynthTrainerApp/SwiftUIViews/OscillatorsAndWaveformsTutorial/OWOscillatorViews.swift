//
//  OWOscillatorViews.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 09/08/2022.
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


struct OWSineOscillatorView: View {
    @StateObject var conductor = OscillatorConductor()
    
    var body: some View {
        VStack {
            
            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
                .padding()
                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
            
            if(self.conductor.data.showKeyboard == false){
                HStack{
                    ParameterSlider(text: "Frequency",
                                    parameter: self.$conductor.data.frequency,
                                    range: 20...880).padding()
                    VStack{
                        Text("Hz ")
                        Text(" ")
                        Text(" ")
                    }
                    
                }
            }
            
//            ParameterSlider(text: "Amplitude",
//                            parameter: self.$conductor.data.amplitude,
//                            range: 0 ... 1).padding()
//            ParameterSlider(text: "Glide",
//                            parameter: self.$conductor.data.rampDuration,
//                            range: 0...10).padding()
            
            //Show Keyboard button
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
                
                self.conductor.osc.setWaveform(Table(.sine))
                
            }.foregroundColor(.red).font(Font.body.bold())
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                Text("Hold key to hold the note")
                KeyboardControl(firstOctave: 3,
                                octaveCount: 1,
                                polyphonicMode: false,
                                delegate: conductor)
            }
        }.cookbookNavBarTitle("Play Sine Wave")
            .onAppear {
                self.conductor.start()
                
                self.conductor.osc.setWaveform(Table(.sine))
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
            
            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
                .padding()
                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
            
            
            
            if(self.conductor.data.showKeyboard == false){
                HStack{
                    ParameterSlider(text: "Frequency",
                                    parameter: self.$conductor.data.frequency,
                                    range: 20...880).padding()
                    VStack{
                        Text("Hz ")
                        Text(" ")
                        Text(" ")
                    }
                    
                }
            }
            
//            ParameterSlider(text: "Amplitude",
//                            parameter: self.$conductor.data.amplitude,
//                            range: 0 ... 1).padding()
//            ParameterSlider(text: "Glide",
//                            parameter: self.$conductor.data.rampDuration,
//                            range: 0...10).padding()
            
            //Show Keyboard button
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
                
                self.conductor.osc.setWaveform(Table(.triangle))
                
            }.foregroundColor(.red).font(Font.body.bold())
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                Text("Hold key to hold the note")
                KeyboardControl(firstOctave: 3,
                                octaveCount: 1,
                                polyphonicMode: false,
                                delegate: conductor)
            }
        }.cookbookNavBarTitle("Play Triangle Wave")
            .onAppear {
                self.conductor.start()
                
                self.conductor.osc.setWaveform(Table(.triangle))
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
            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
                .padding()
                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
            
            
            
            if(self.conductor.data.showKeyboard == false){
                HStack{
                    ParameterSlider(text: "Frequency",
                                    parameter: self.$conductor.data.frequency,
                                    range: 20...880).padding()
                    VStack{
                        Text("Hz ")
                        Text(" ")
                        Text(" ")
                    }
                    
                }
            }
//
//            ParameterSlider(text: "Amplitude",
//                            parameter: self.$conductor.data.amplitude,
//                            range: 0 ... 1).padding()
//            ParameterSlider(text: "Glide",
//                            parameter: self.$conductor.data.rampDuration,
//                            range: 0...10).padding()
            
            //Show Keyboard button
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
                
                self.conductor.osc.setWaveform(Table(.sawtooth))
                
            }.foregroundColor(.red).font(Font.body.bold())
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                Text("Hold key to hold the note")
                KeyboardControl(firstOctave: 3,
                                octaveCount: 1,
                                polyphonicMode: false,
                                delegate: conductor)
            }
        }.cookbookNavBarTitle("Play Sawtooth Wave")
            .onAppear {
                self.conductor.start()
                
                self.conductor.osc.setWaveform(Table(.sawtooth))
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

            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
                .padding()
                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
            
            
            
            if(self.conductor.data.showKeyboard == false){
                HStack{
                    ParameterSlider(text: "Frequency",
                                    parameter: self.$conductor.data.frequency,
                                    range: 20...880).padding()
                    VStack{
                        Text("Hz ")
                        Text(" ")
                        Text(" ")
                    }
                    
                }
            }
            
//            ParameterSlider(text: "Amplitude",
//                            parameter: self.$conductor.data.amplitude,
//                            range: 0 ... 1).padding()
//            ParameterSlider(text: "Glide",
//                            parameter: self.$conductor.data.rampDuration,
//                            range: 0...10).padding()
            
            //Show Keyboard button
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
                
                self.conductor.osc.setWaveform(Table(.square))
                
            }.foregroundColor(.red).font(Font.body.bold())
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                Text("Hold key to hold the note")
                KeyboardControl(firstOctave: 3,
                                octaveCount: 1,
                                polyphonicMode: false,
                                delegate: conductor)
            }
        }.cookbookNavBarTitle("Play Square Wave")
            .onAppear {
                self.conductor.start()
                
                self.conductor.osc.setWaveform(Table(.square))
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
            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
                .padding()
                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
            
            ParameterSlider(text: "Pulse Width",
                            parameter: self.$conductor.data.pulseWidth,
                            range: 0 ... 1).padding(5)
            if(self.conductor.data.showKeyboard == false){
                HStack{
                    ParameterSlider(text: "Frequency",
                                    parameter: self.$conductor.data.frequency,
                                    range: 20...880).padding()
                    VStack{
                        Text("Hz ")
                        Text(" ")
                        Text(" ")
                    }
                    
                }
            }
//            HStack{
//                ParameterSlider(text: "Amplitude",
//                                parameter: self.$conductor.data.amplitude,
//                                range: 0 ... 1).padding()
//                VStack{
//                    Text(" /1   ")
//                    Text(" ")
//                    Text(" ")
//                }
//            }
//            HStack{
//            ParameterSlider(text: "Glide Time",
//                            parameter: self.$conductor.data.rampDuration,
//                            range: 0...10).padding()
//                VStack{
//                    Text("secs ")
//                    Text(" ")
//                    Text(" ")
//                }
//            }
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
            }.foregroundColor(.red).font(Font.body.bold())
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                Text("Hold key to hold the note")
                KeyboardControl(firstOctave: 3,
                                octaveCount: 1,
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

struct PWMGlideOscillatorView: View {
    @StateObject var conductor = PWMOscillatorConductor()
    
    var body: some View {
        VStack {
            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
                .padding()
                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
            
            ParameterSlider(text: "Pulse Width",
                            parameter: self.$conductor.data.pulseWidth,
                            range: 0 ... 1).padding(5)
            if(self.conductor.data.showKeyboard == false){
                HStack{
                    ParameterSlider(text: "Frequency",
                                    parameter: self.$conductor.data.frequency,
                                    range: 20...880).padding()
                    VStack{
                        Text("Hz ")
                        Text(" ")
                        Text(" ")
                    }
                    
                }
            }
            HStack{
                ParameterSlider(text: "Amplitude",
                                parameter: self.$conductor.data.amplitude,
                                range: 0 ... 1).padding()
                VStack{
                    Text(" /1   ")
                    Text(" ")
                    Text(" ")
                }
            }
            HStack{
            ParameterSlider(text: "Glide Time",
                            parameter: self.$conductor.data.rampDuration,
                            range: 0...10).padding()
                VStack{
                    Text("secs ")
                    Text(" ")
                    Text(" ")
                }
            }
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
            }.foregroundColor(.red).font(Font.body.bold())
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                Text("Hold key to hold the note")
                KeyboardControl(firstOctave: 3,
                                octaveCount: 1,
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
            
            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
                self.conductor.data.isPlaying.toggle()
            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
                .padding()
                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
            
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
                NavigationLink(destination: PWMGlideOscillatorView()){
                    Text("Pulse").foregroundColor(.purple).font(Font.body.bold())
                }.padding()
                Spacer()
                
            }
 
            if(self.conductor.data.showKeyboard == false){
                HStack{
                    ParameterSlider(text: "Frequency",
                                    parameter: self.$conductor.data.frequency,
                                    range: 20...880).padding()
                    VStack{
                        Text("Hz ")
                        Text(" ")
                        Text(" ")
                    }
                    
                }
            }
            
            HStack{
                ParameterSlider(text: "Amplitude",
                                parameter: self.$conductor.data.amplitude,
                                range: 0 ... 1).padding()
                VStack{
                    Text(" /1   ")
                    Text(" ")
                    Text(" ")
                }
            }
            
            HStack{
            ParameterSlider(text: "Glide Time",
                            parameter: self.$conductor.data.rampDuration,
                            range: 0...10).padding()
                VStack{
                    Text("secs ")
                    Text(" ")
                    Text(" ")
                }
            }
            
            //Show Keyboard button
            
            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
                self.conductor.data.showKeyboard.toggle()
                
            }.foregroundColor(.red).font(Font.body.bold())
            
            NodeOutputView(conductor.osc)
            
            if(self.conductor.data.showKeyboard){
                Text("Hold key to hold the note")
                KeyboardControl(firstOctave: 3,
                                octaveCount: 1,
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
