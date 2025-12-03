//
//  TabBarView.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

struct TabBarView: View {
    
    @Environment(AppState.self) private var appState
    @State private var selectedTab = 0
    @State private var showAlert = false
    @State private var goToProfile = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
           
            NavigationStack {
                DashboardView()
                    .navigationDestination(isPresented: $goToProfile) {
                        ProfileView()
                    }
                    .onAppear {
                        if appState.showProfileSetupAlert {
                            showAlert = true
                        }
                    }
                    .alert("Let's finish setting up your profile", isPresented: $showAlert) {
                        Button("Continue") {
                            appState.showProfileSetupAlert = false
                            goToProfile = true
                        }
                        Button("Later", role: .cancel) {
                            appState.showProfileSetupAlert = false
                        }
                    }
            }
            .tabItem {
                Image(selectedTab == 0 ? "orange-house" : "house")
                Text("Dashboard")
            }
            .tag(0)
                
            NavigationStack { MealView() }
                .tabItem {
                    Image(selectedTab == 1 ? "orange-food" : "food")
                    Text("Meals")
                }
                .tag(1)
                
            NavigationStack { ActivityView() }
                .tabItem {
                    Image(selectedTab == 2 ? "orange-lightning" : "lightning")
                    Text("Exercising")
                }
                .tag(2)
                
            NavigationStack { SettingsView() }
                .tabItem {
                    Image(selectedTab == 3 ? "orange-gear" : "gear")
                    Text("Settings")
                }
                .tag(3)
        }
    }
}


#Preview {
    TabBarView()
        .environment(AppState())
       
}

