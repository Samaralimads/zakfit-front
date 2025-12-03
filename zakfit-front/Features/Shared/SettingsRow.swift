//
//  SettingsRow.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 03/12/2025.
//

import SwiftUI

struct SettingsRow: View {
    let label: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
    }
}

