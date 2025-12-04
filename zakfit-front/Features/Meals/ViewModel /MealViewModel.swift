//
//  MealViewModel.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 04/12/2025.
//

import Foundation

@Observable
final class MealViewModel {
    // MARK: - State
    var meals: [Meal] = []
    var mealTypes: [MealType] = []
    var mealItems: [MealItem] = []
    var customMealItems: [CustomMealItem] = []

    var isLoading: Bool = false
    var errorMessage: String?

    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    private var token: String? {
        appState.token
    }

    // MARK: - Load Everything
    func loadAll() async {
        guard let token else {
            errorMessage = "User not logged in"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            async let types = MealService.getMealTypes(token: token)
            async let meals = MealService.getMeals(token: token)
            async let items = MealService.getMealItems(token: token)
            async let custom = MealService.getCustomMealItems(token: token)

            self.mealTypes = try await types
            self.meals = try await meals
            self.mealItems = try await items
            self.customMealItems = try await custom

        } catch {
            print("MealViewModel Error:", error)
            self.errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    // MARK: - Refresh only meals
    func refreshMeals() async {
        guard let token else { return }

        do {
            let newMeals = try await MealService.getMeals(token: token)
            self.meals = newMeals
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

    // MARK: - get details
    func items(for meal: Meal) -> [MealItem] {
        meal.mealItemIds.compactMap { id in
            mealItems.first(where: { $0.id == id })
        }
    }

    func customItems(for meal: Meal) -> [CustomMealItem] {
        meal.customMealItemIds.compactMap { id in
            customMealItems.first(where: { $0.id == id })
        }
    }


    // MARK: - Add item to a meal
    func addItemToMeal(
        mealId: UUID,
        mealItemId: UUID?,
        customItemId: UUID?,
        quantity: Double
    ) async -> Bool {

        guard let token else { return false }

        let req = AddMealItemRequest(
            mealId: mealId,
            mealItemId: mealItemId,
            customItemId: customItemId,
            quantity: quantity
        )

        do {
            try await MealService.addItemToMeal(token: token, req: req)

            // Reload the meal list after adding item
            await refreshMeals()
            return true

        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
