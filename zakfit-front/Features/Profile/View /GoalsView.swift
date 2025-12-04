//
//  GoalsView.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 03/12/2025.
//

import SwiftUI

struct GoalsView: View {
    
    enum Tab: String, CaseIterable {
        case meals = "Meals"
        case exercising = "Exercising"
    }
    
    @State private var selectedTab: Tab = .meals
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text("My goals")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Picker("", selection: $selectedTab) {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        Text(tab.rawValue).tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .preferredColorScheme(ColorScheme.dark)
                
                Group {
                    switch selectedTab {
                    case .meals:
                        MealGoalView()
                    case .exercising:
                        ActivityGoalView()
                    }
                }
                .transition(.opacity)
//                Spacer()
            }
        }
        .animation(.easeInOut, value: selectedTab)
    }
}

#Preview {
    GoalsView()
}
