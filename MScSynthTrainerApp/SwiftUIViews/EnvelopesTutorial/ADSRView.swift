//
//  ADSRView.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 09/08/2022.
//
// AudioKit Amplitude Envelope Control Object Mapping
//

import AudioKit
import AudioKitUI
import SwiftUI
import AVFoundation

struct ADSRWidget: UIViewRepresentable {
    
    typealias UIViewType = ADSRView
    var callback: (AUValue, AUValue, AUValue, AUValue) -> Void
    
    func makeUIView(context: Context) -> ADSRView {
        let view = ADSRView(callback: callback)
        view.bgColor = .systemBackground
        return view
    }
    
    func updateUIView(_ uiView: ADSRView, context: Context) {
        //
    }
    
}
