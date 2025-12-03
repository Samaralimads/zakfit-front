//
//  SetupCompleteView.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

struct SetupCompleteView: View {
    var body: some View {
        ZStack{
            Color(.preto)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center){
                Text("Profile Setup Complete!")
                    .font(.custom("Montserrat-Bold", size: 28))
                    .foregroundStyle(.white)
                    .padding(.bottom, 8)
                
                Text("Great job! You’re all set to start tracking\n your meals and reaching your goals.")
                    .font(.custom("Montserrat-SemiBold", size: 13))
                    .foregroundStyle(.accent)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Image("banana")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 245, height: 270)
                    
            
                
                Spacer()
                
                CustomButton(title: "Go to your dashboard") {
                //action
                }
            }
            .padding(.vertical, 40)
        }
    }
}


#Preview {
    SetupCompleteView()
}
