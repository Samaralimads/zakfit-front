//
//  CalorieGoalView.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

struct MealGoalView: View {
    
    @Environment(AppState.self) private var appState
    @State private var vm: MealGoalViewModel
    
    init() {
        _vm = State(initialValue: MealGoalViewModel(token: "", userId: nil))
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                FormInputField(
                    label: "Calories",
                    placeholder: "0 kcal",
                    text: $vm.kcal,
                    keyboard: .numberPad
                )
                .padding(.horizontal)
                
                Toggle(isOn: $vm.autoCalculate) {
                    Text("Automatically calculate my calories using my BMR")
                        .font(.caption)
                        .foregroundColor(.gray.opacity(0.9))
                }
                .toggleStyle(SwitchToggleStyle(tint: .accent))
                .padding(.horizontal)
                
                FormInputField(
                    label: "Protein",
                    placeholder: "0",
                    text: $vm.protein,
                    keyboard: .numberPad
                )
                .padding(.horizontal)
                
                FormInputField(
                    label: "Carbs",
                    placeholder: "0",
                    text: $vm.carbs,
                    keyboard: .numberPad
                )
                .padding(.horizontal)
                
                FormInputField(
                    label: "Fat",
                    placeholder: "0",
                    text: $vm.fat,
                    keyboard: .numberPad
                )
                .padding(.horizontal)
                
                Spacer().frame(height: 20)
                
                CustomButton(title: vm.isLoading ? "Saving..." : "Save") {
                    Task { await vm.save() }
                }
                .padding(.horizontal)
                .opacity(vm.isLoading ? 0.6 : 1)
                .disabled(vm.isLoading)
                
                Spacer().frame(height: 40)
            }
            .padding(.top, 20)
            
            if vm.isLoading {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                ProgressView("Loading...")
                    .foregroundColor(.white)
            }
        }
        .task {
            await vm.loadUserTokenAndGoal(token: appState.token ?? "")
        }
    }
}

#Preview {
    MealGoalView()
        .environment(AppState())
}

