//
//  RegisterView.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(AppState.self) private var appState
    @State private var vm: RegisterViewModel
    
    init() {
        _vm = State(initialValue: RegisterViewModel()) 
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("papaya")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 181)
                        .padding(.bottom, 16)
                    
                    Text("Create your account")
                        .font(.custom("Montserrat-Bold", size: 28))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    VStack(spacing: 15) {
                        TextField("First Name", text: $vm.firstName)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("Last Name", text: $vm.lastName)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("Email", text: $vm.email)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $vm.password)
                            .textFieldStyle(.roundedBorder)
                        
                        SecureField("Confirm Password", text: $vm.confirmPassword)
                            .textFieldStyle(.roundedBorder)
                        
                        if let error = vm.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .font(.footnote)
                        }
                        
                        if vm.isLoading {
                            ProgressView()
                                .padding()
                        }
                    }
                    
                    Spacer()
                    
                    CustomButton(title: "Sign Up") {
                        Task {
                            await vm.register(appState: appState)
                        }
                    }
                    
                    HStack {
                        Text("Already have an account?")
                            .font(.custom("Montserrat-Medium", size: 13))
                            .foregroundStyle(.white)
                        
                        NavigationLink("Login") {
                            LoginView()
                                .environment(appState)
                        }
                        .font(.custom("Montserrat-Medium", size: 13))
                        .foregroundStyle(.orange)
                    }
                    .padding(.top, 16)
                }
                .padding(18)
            }
        }
    }
}

#Preview {
    RegisterView()
        .environment(AppState())
}
