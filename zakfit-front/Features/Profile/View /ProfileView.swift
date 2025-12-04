//
//  ProfileView.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(AppState.self) private var appState
    @State private var vm: ProfileViewModel
    
    init() {
        _vm = State(initialValue: ProfileViewModel())
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack() {
                Text("Profile")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                VStack(spacing: 16) {
                    
                    FormInputField(placeholder: "First Name", text: $vm.firstName)
                    FormInputField(placeholder: "Last Name", text: $vm.lastName)
                    FormInputField(placeholder: "Email", text: $vm.email, keyboard: .emailAddress)
                    
                    HStack(spacing: 16) {
                        FormInputField(placeholder: "Age", text: $vm.age, keyboard: .numberPad)
                        
                        SimpleDropdown(
                            title: "Gender",
                            selection: $vm.gender,
                            options: vm.genderOptions
                        )
                    }
                    
                    HStack(spacing: 16) {
                        FormInputField(placeholder: "Height", text: $vm.height, rightText: "cm", keyboard: .numberPad)
                        FormInputField(placeholder: "Weight", text: $vm.weight, rightText: "kg", keyboard: .numberPad)
                    }
                    
                    SimpleDropdown(
                        title: "Dietary Preferences",
                        selection: $vm.dietary,
                        options: vm.dietaryOptions
                    )
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
                
                CustomButton(title: vm.isLoading ? "Saving..." : "Save Changes") {
                    Task {
                        await vm.updateProfile(token: appState.token ?? "")
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .task {
            await vm.loadUser(token: appState.token ?? "")
        }
    }
}

#Preview {
    ProfileView()
        .environment(AppState())
}
