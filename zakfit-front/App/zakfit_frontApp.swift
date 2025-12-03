//
//  zakfit_frontApp.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 25/11/2025.
//

import SwiftUI

@main
struct zakfit_frontApp: App {
    @State private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if !appState.isLoggedIn {
                WelcomeView()
                    .environment(appState)
            } else {
                TabBarView()
                    .environment(appState)
            }
        }
    }
}
