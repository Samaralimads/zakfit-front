//
//  ReusableButton.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 231, alignment: .center)
                .padding(.horizontal, 55)
                .padding(.vertical, 17)
                .background(.accent)
                .cornerRadius(50)
        }
    }
}

#Preview {
    CustomButton(title: "Next") {
        print("Button tapped")
    }
    .padding()
}

