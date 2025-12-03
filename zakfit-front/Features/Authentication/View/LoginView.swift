//
//  LoginView.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(AppState.self) private var appState
    @State private var vm = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("papaya")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 181)
                        .padding(.bottom, 16)
                    
                    Text("Welcome Back!")
                        .font(.custom("Montserrat-Bold", size: 28))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        FormInputField(
                            placeholder: "Email",
                            text: $vm.email,
                            keyboard: .emailAddress
                        )
                        
                        FormInputField(
                            placeholder: "Password",
                            text: $vm.password,
                            isSecure: true
                        )
                        
                        if vm.isLoading {
                            ProgressView()
                        }
                        
                        Spacer()
                        
                        CustomButton(title: "Login") {
                            Task {
                                await vm.login(appState: appState)
                            }
                        }
                        
                        HStack {
                            Text("You're new here?")
                                .font(.custom("Montserrat-Medium", size: 13))
                                .foregroundStyle(.white)
                            
                            NavigationLink("Signup") {
                                RegisterView()
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
}

    
#Preview {
    LoginView()
        .environment(AppState()) 
}
