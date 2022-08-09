import AudioKit
import AudioKitUI
import SwiftUI
import AVFoundation

struct DryWetMixView: View {
    var dry: Node
    var wet: Node
    var mix: Node

    var height: CGFloat = 100

    func plot(_ node: Node, label: String, color: Color) -> some View {
        VStack {
            HStack { Text(label); Spacer() }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(hue: 0, saturation: 0, brightness: 0.5, opacity: 0.2))
                    .frame(height: height)
                NodeOutputView(node, color: color).frame(height: height).clipped()
            }
        }
    }

    var body: some View {
        HStack(spacing: 30) {
            plot(dry, label: "Input Signal", color: .red)
//            plot(wet, label: "Processed Signal", color: .blue)
            plot(mix, label: "Filtered Output", color: .purple)
        }
    }
}
