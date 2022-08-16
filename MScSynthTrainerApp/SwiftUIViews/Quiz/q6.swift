//
//  q6.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 16/08/2022.
//

import AudioKit
import AudioKitUI
import SoundpipeAudioKit
import SwiftUI
import AudioToolbox
import AVFoundation
import AudioKitEX
import CAudioKitEX

// O and Ws: Yellow

struct q6: View {
    
@EnvironmentObject var scoreTracker: ScoreTracker
@EnvironmentObject var questionCount: QuestionCount


// Store didtap values
@State private var didTapA:Bool = false
@State private var didTapB:Bool = false
@State private var didTapC:Bool = false
@State private var didTapD:Bool = false

@State private var lock:Bool = false

@State private var scoreLock:Bool = false

@StateObject var conductor = PWMOscillatorConductor()


var body: some View {
    
    VStack {
        
        Text("Which Oscillator parameter does this slider control?")
            .font(.system(size: 20))
            .fontWeight(.bold)
//                .padding()
        
        
        Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
            self.conductor.data.isPlaying.toggle()
        }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
            .padding()
            .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
        
        ParameterSlider(text: "",
                        parameter: self.$conductor.data.pulseWidth,
                        range: 0 ... 1).padding(5)
            .frame(width: 300, height: 70)
        
        NodeOutputView(conductor.osc)
            .frame(width: 300, height: 70)
        

        
// ****** Answer A **********************
        
        Button(action: {
            if(self.lock == false){
                self.didTapA = true
            }
            self.lock = true
            
        }){
            Text("Pitch / Frequency")
                .foregroundColor(self.didTapA ? .red : .black)
                .font(Font.body.bold())
                .padding()
                .frame(maxWidth: 350)
                .border(self.didTapA ? .red : .black, width: 3)
        }
        
// ****************************************
        
// ****** Answer B ************************
        
        Button(action: {
            if(self.lock == false){
                self.didTapB = true
            }
            self.lock = true
            
        }){
            Text("Amplitude / Volume")
                .foregroundColor(self.didTapB ? .red : .black)
            
                .font(Font.body.bold())
                .padding()
                .frame(maxWidth: 350)
                .border(self.didTapB ? .red : .black, width: 3)
        }
// ****************************************
        
// ****** Answer C ************************
        
        Button(action: {
            if(self.lock == false){
                self.didTapC = true
            }
            self.lock = true
            
        }){
            Text("Glide")
                .foregroundColor(self.didTapC ? .red : .black)
                
                .font(Font.body.bold())
                .padding()
                .frame(maxWidth: 350)
                .border(self.didTapC ? .red : .black, width: 3)
        }
        
        
// ****************************************
        
        
// ****** Answer D ************************
        
        Button(action: {
            if(self.lock == false){
                self.didTapD = true
            }
            self.lock = true
            
        }){
            Text("Pulse-width Modulation")
                .foregroundColor(self.didTapD ? .green : .black)
                
                .font(Font.body.bold())
                .padding()
                .frame(maxWidth: 350)
                .border(self.didTapD ? .green : .black, width: 3)
        }

// ****************************************
        
// ************ Response ******************
        
        
        
    
        //Correct
        if(self.didTapD){
            Text("Correct!")
                .foregroundColor(.green)
                .padding()
            
            NavigationLink(destination: q7()
            .navigationBarBackButtonHidden(true)
            ){
                Text("Next")
                    .foregroundColor(.blue)
                
                    .font(Font.body.bold())
                    .padding()
                    .frame(maxWidth: 350)
                    .border(.blue, width: 3)
            }.onAppear{
                //                    UserDefaults.standard.setQ1Result(value: 1)
                
                if(scoreLock == false){
                    scoreTracker.score += 1
                    questionCount.count += 1
                }
                
                scoreLock = true
            }
        }
        
        // Incorrect
        if(self.didTapB || self.didTapC || self.didTapA){
            Text("Incorrect, this slide controls Pulse-width Modulation")
                .foregroundColor(.red)
                .padding()
            
            NavigationLink(destination: q7()
            .navigationBarBackButtonHidden(true)
            ){
                Text("Next")
                    .foregroundColor(.blue)
                
                    .font(Font.body.bold())
                    .padding()
                    .frame(maxWidth: 350)
                    .border(.blue, width: 3)
            }.onAppear{
                questionCount.count += 1
            }
            

        }
    }
    // Colour code border
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .border(.yellow, width: 16)
    .toolbar {
        ToolbarItemGroup(placement: .navigationBarLeading) {
            NavigationLink(destination: QuizSummary()
            .navigationBarBackButtonHidden(true)
            ){
                Text("Quit Quiz")
//                        .font(Font.body.bold())
                    .foregroundColor(.blue)
            }
        }
    }
    .onAppear {
        self.conductor.start()
    }
    .onDisappear {
        self.conductor.stop()
    }
}
}

//
//struct Q4PWMGlideOscillatorView: View {
//    @StateObject var conductor = PWMOscillatorConductor()
//
//    var body: some View {
//        VStack {
//            Text(self.conductor.data.isPlaying ? "||" : "▶︎").onTapGesture {
//                self.conductor.data.isPlaying.toggle()
//            }.foregroundColor(self.conductor.data.isPlaying ? .orange : .green).font(Font.body.bold())
//                .padding()
//                .border(self.conductor.data.isPlaying ? .orange : .green, width: 4)
//
//            ParameterSlider(text: "Pulse Width",
//                            parameter: self.$conductor.data.pulseWidth,
//                            range: 0 ... 1).padding(5)
//            if(self.conductor.data.showKeyboard == false){
//                HStack{
//                    ParameterSlider(text: "Frequency",
//                                    parameter: self.$conductor.data.frequency,
//                                    range: 20...880).padding()
//                    VStack{
//                        Text("Hz ")
//                        Text(" ")
//                        Text(" ")
//                    }
//
//                }
//            }
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
//
//            Text(self.conductor.data.showKeyboard ? "Hide Keyboard" : "Show Keyboard").onTapGesture {
//                self.conductor.data.showKeyboard.toggle()
//            }.foregroundColor(.red).font(Font.body.bold())
//
//            NodeOutputView(conductor.osc)
//
//            if(self.conductor.data.showKeyboard){
//                Text("Hold key to hold the note")
//                KeyboardControl(firstOctave: 3,
//                                octaveCount: 1,
//                                polyphonicMode: false,
//                                delegate: conductor)
//            }
//
//        }.cookbookNavBarTitle("Play with Pulse Wave")
//            .onAppear {
//                self.conductor.start()
//            }
//            .onDisappear {
//                self.conductor.stop()
//            }
//    }
//}

struct q6_Previews: PreviewProvider {
    static var previews: some View {
        q6()
    }
}
