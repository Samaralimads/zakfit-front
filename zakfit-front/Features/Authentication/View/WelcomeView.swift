//
//  WelcomeView.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(AppState.self) private var appState

    var body: some View {
        NavigationStack{
            ZStack{
                Color(.preto)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center){
                    Text("ZAKFIT")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Image("orange")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 284, height: 285)
                    
                    Spacer()
                    
                    Text("Fuel your body, \nMove with purpose")
                        .font(.custom("Montserrat-SemiBold", size: 26))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    NavigationLink(destination: RegisterView()){
                        Text("Get Started")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 231, alignment: .center)
                            .padding(.horizontal, 55)
                            .padding(.vertical, 17)
                            .background(.accent)
                            .cornerRadius(50)
                    }
                }
                .padding(18)
            }
        }
    }
}

#Preview {
    WelcomeView()
        .environment(AppState())
}
