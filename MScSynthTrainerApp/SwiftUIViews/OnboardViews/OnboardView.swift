//
//  OnboardView.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 22/07/2022.
//
// Default Tutorial TabView Slides OnboardViews with one or two images.
//

import SwiftUI

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

struct OnboardViewOneImage: View {
    
    let systemImageName1: String
    let title: String
    let description: String
    
    var body: some View {
        
        VStack(spacing: 20){
            HStack{
                Image(systemImageName1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
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
