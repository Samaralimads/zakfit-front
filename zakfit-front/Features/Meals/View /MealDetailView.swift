//
//  MealDetailView.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 04/12/2025.
//

import SwiftUI

struct MealDetailView: View {
    let meal: Meal
    var viewModel: MealViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 24) {
              
                Text(viewModel.mealTypes.first { $0.id == meal.mealTypeId }?.name ?? "Unknown")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)


                // MARK: - Macros Grid
                LazyVGrid(columns: columns, spacing: 16) {
                    MacroCard(title: "Calories",
                              value: "\(meal.totalKcal) kcal",
                              color: .lilas)

                    MacroCard(title: "Protein",
                              value: "\(meal.totalProtein) g",
                              color: .verde)

                    MacroCard(title: "Carbs",
                              value: "\(meal.totalCarbs) g",
                              color: .amarelo)

                    MacroCard(title: "Fat",
                              value: "\(meal.totalFat) g",
                              color: .accent)
                }

                // MARK: - Items Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Items")
                        .font(.title2.bold())
                        .foregroundStyle(.white)

                    // inside Items Section
                    ForEach(meal.mealItemIds, id: \.self) { id in
                        if let item = viewModel.mealItems.first(where: { $0.id == id }) {
                            MealItemRow(item: item)
                        }
                    }

                    ForEach(meal.customMealItemIds, id: \.self) { id in
                        if let item = viewModel.customMealItems.first(where: { $0.id == id }) {
                            CustomMealItemRow(item: item)
                        }
                    }
                }

                Spacer(minLength: 40)
            }
            .padding()
        }
    }
}

#Preview {
    let dummyMeal = Meal(
        id: UUID(),
        date: Date(),
        userId: UUID(),
        mealTypeId: UUID(),
        mealItemIds: [],
        customMealItemIds: [],
        totalKcal: 1000,
        totalProtein: 30,
        totalCarbs: 50,
        totalFat: 10
    )

    let dummyVM = MealViewModel(appState: AppState())

    MealDetailView(meal: dummyMeal, viewModel: dummyVM)
}
