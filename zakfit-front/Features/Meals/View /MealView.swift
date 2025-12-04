//
//  MealView.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

struct MealView: View {
    @Environment(AppState.self) var appState
    @Environment(MealViewModel.self) var viewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack {
                    Text("Meal")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.bottom, 20)

                    HStack {
                        Button(action: {
                            // TODO: handle previous day
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                        Spacer()
                        Text("Today")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            // TODO: handle next day
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                    }
                    .padding()
                    .padding(.bottom, 20)

                    // Meals list
                    VStack(spacing: 16) {
                        ForEach(viewModel.meals) { meal in
                            NavigationLink(destination: MealDetailView(meal: meal, viewModel: viewModel)) {
                                MealCard(
                                    title: mealTypeName(for: meal),
                                    kcal: meal.totalKcal,
                                    protein: meal.totalProtein,
                                    carbs: meal.totalCarbs,
                                    fat: meal.totalFat,
                                    color: colorForMeal(meal)
                                )
                            }
                        }
                    }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    

                    Spacer()
                }

                // Loading overlay
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                }
            }
            .task {
                await viewModel.loadAll()
                print("Loaded meals:", viewModel.meals)
                   print("Error message:", viewModel.errorMessage ?? "none")
            }
        }
    }

    // MARK: - Helpers
    func mealTypeName(for meal: Meal) -> String {
        viewModel.mealTypes.first(where: { $0.id == meal.mealTypeId })?.name ?? "Meal"
    }

    func colorForMeal(_ meal: Meal) -> Color {
        switch mealTypeName(for: meal).lowercased() {
        case "breakfast": return Color.amarelo
        case "lunch": return Color.lilas
        case "snack": return Color.verde
        case "dinner": return Color.accent
        default: return Color.gray
        }
    }
}

#Preview {
    MealView()
        .environment(AppState())
        .environment(MealViewModel(appState: AppState()))
}
