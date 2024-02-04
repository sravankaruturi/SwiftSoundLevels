//
//  ContentView.swift
//  AudioLevels
//
//  Created by Sravan Karuturi on 2/1/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    @State private var audioLevel: Float = 0.0
    
    @State private var data: [ChartData] = []
    @State var time: Float = 0.0

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        VStack {
            
            Text(String(audioLevel) + " dB")
            
            Graph(data: $data)

            Toggle("Show Immersive Space", isOn: $showImmersiveSpace)
                .toggleStyle(.button)
                .padding(.top, 50)
        }
        .padding()
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
        .onAppear{
            AudioCapture.setupAudioCapture()
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                AudioCapture.audioRec!.updateMeters()
                let db = AudioCapture.audioRec!.averagePower(forChannel: 0)  // -160 to 0 db
                audioLevel = db
                data.append(ChartData(value: audioLevel, time: time))
                if data.count >= 600 {
                    data.remove(at: 0)
                }
                time += 0.1
                print(db)
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
