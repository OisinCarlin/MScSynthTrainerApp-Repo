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
            OnboardViewOneImage(systemImageName1: "lowPassFilter",
                                title: "Filters",
                                description: "Filters...")
            LPFLinkView(systemImageName1: "lowPassFilter",
                        title: "Low Pass Filter",
                        description: "Click to Play with Low Pass Filter")
            HPFLinkView(systemImageName1: "lowPassFilter",
                        title: "High Pass Filter",
                        description: "Click to Play with High Pass Filter")
        }
        
        
        .tabViewStyle(PageTabViewStyle())
        
        // To display page dots on bottom of view
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct LPFLinkView: View {
    
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
            
            NavigationLink(destination: LowPassFilterView()){
                Text("Play with Low Pass Filter").foregroundColor(.purple).font(Font.body.bold())
            }.padding()
        }
        .padding(.horizontal, 40)
    }
}

struct HPFLinkView: View {
    
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
            
            NavigationLink(destination: HighPassFilterView()){
                Text("Play with High Pass Filter").foregroundColor(.purple).font(Font.body.bold())
            }.padding()
        }
        .padding(.horizontal, 40)
    }
}


struct FiltersTutorial_Previews: PreviewProvider {
    static var previews: some View {
        FiltersTutorial()
    }
}
