//
//  AudioKitUI.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 26/08/2022.
//
// Re-included deprecated code upon AudioKit Cookbook's Keyboard Update
//


import Accelerate
import AudioKit
import SwiftUI

#if os(macOS)
public typealias ViewRepresentable = NSViewRepresentable
#else
public typealias ViewRepresentable = UIViewRepresentable
#endif

public extension Color {
    var cg: CGColor {
        return CrossPlatformColor(self).cgColor
    }
}

public extension EnvironmentValues {
    var isPreview: Bool {
        #if DEBUG
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        #else
        return false
        #endif
    }
}


