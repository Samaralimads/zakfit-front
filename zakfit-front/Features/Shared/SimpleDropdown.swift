//
//  SimpleDropdown.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 03/12/2025.
//

import SwiftUI

struct SimpleDropdown: View {
    var title: String
    @Binding var selection: String
    var options: [String]
    
    @State private var expanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
         
            Button {
                withAnimation { expanded.toggle() }
            } label: {
                HStack {
                    Text(selection.isEmpty ? title : selection)
                        .foregroundColor(selection.isEmpty ? .white.opacity(0.4) : .white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.white.opacity(0.6))
                        .rotationEffect(.degrees(expanded ? -180 : 0))
                }
                .padding()
                .background(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 1)
                )
                .cornerRadius(25)
            }
            
            if expanded {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                            .onTapGesture {
                                selection = option
                                withAnimation { expanded = false }
                            }
                    }
                }
                .padding(12)
                .background(Color.white.opacity(0.05))
                .cornerRadius(12)
            }
        }
    }
}

