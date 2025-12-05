//
//  SettingsView.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 03/12/2025.
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @Environment(AppState.self) private var appState
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        HStack {
                            Text("Settings")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Image("papaya")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140)
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                        VStack(spacing: 0) {
                            
                            NavigationLink {
                                ProfileView()
                            } label: {
                                SettingsRow(label: "Profile")
                            }
                            
                            Divider().background(Color.white.opacity(0.1))
                            
                            NavigationLink {
                                GoalsView()
                            } label: {
                                SettingsRow(label: "My goals")
                            }
                            
                            Divider().background(Color.white.opacity(0.1))
                            
                            NavigationLink {
                                ChangePasswordView()
                            } label: {
                                SettingsRow(label: "Change Password")
                            }
                            
                            Divider().background(Color.white.opacity(0.1))
                            
                            HStack {
                                Text("Notifications")
                                    .foregroundColor(.white)
                                Spacer()
                                
                                Toggle("", isOn: $notificationsEnabled)
                                    .toggleStyle(SwitchToggleStyle(tint: .accent))
                                    .labelsHidden()
                            }
                            .padding()
                            
                        }
                        .background(Color(.systemGray6).opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .padding(.horizontal)
                        
                        Button {
                            appState.logout()
                        } label: {
                            Text("Log Out")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemGray6).opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                }
            }           
        }
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
