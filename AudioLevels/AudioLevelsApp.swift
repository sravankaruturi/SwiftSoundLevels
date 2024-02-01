//
//  AudioLevelsApp.swift
//  AudioLevels
//
//  Created by Sravan Karuturi on 2/1/24.
//

import SwiftUI

@main
struct AudioLevelsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
