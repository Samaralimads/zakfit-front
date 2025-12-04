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
    @State private var mealVM: MealViewModel

    init() {
        let appState = AppState()
        _appState = State(initialValue: appState)
        _mealVM = State(initialValue: MealViewModel(appState: appState))
    }

    var body: some Scene {
        WindowGroup {
            if !appState.isLoggedIn {
                WelcomeView()
                    .environment(appState)
                    .environment(mealVM)
            } else {
                TabBarView()
                    .environment(appState)
                    .environment(mealVM)
            }
        }
    }
}
