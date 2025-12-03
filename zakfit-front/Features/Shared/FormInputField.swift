//
//  FormInputField.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 03/12/2025.
//

import SwiftUI

struct FormInputField: View {
    var label: String?
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var rightText: String? = nil
    var rightIcon: String? = nil
    var keyboard: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            if let label = label {
                Text(label)
                    .foregroundColor(.white.opacity(0.9))
                    .font(.subheadline)
            }
            
            ZStack(alignment: .leading) {
                
                // Custom placeholder
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.white.opacity(0.4))  // <<< WHITE PLACEHOLDER
                        .padding(.horizontal, 16)
                }
                
                
                HStack {
                    
                    if isSecure {
                        SecureField(placeholder, text: $text)
                            .foregroundColor(.white)
                            .keyboardType(keyboard)
                    } else {
                        TextField(placeholder, text: $text)
                            .foregroundColor(.white)
                            .keyboardType(keyboard)
                    }
                    
                    if let rightText = rightText {
                        Text(rightText)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    
                    if let rightIcon = rightIcon {
                        Image(systemName: rightIcon)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                }
                .padding()
                .background(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 1)
                )
                .cornerRadius(25)
            }
        }
    }
}
