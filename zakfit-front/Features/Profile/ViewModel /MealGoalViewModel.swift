//
//  MealGoalViewModel.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 03/12/2025.
//

import Foundation

@Observable
final class MealGoalViewModel {

    var kcal: String = ""
    var protein: String = ""
    var carbs: String = ""
    var fat: String = ""
    var autoCalculate: Bool = false

    var isLoading = false
    var errorMessage: String?
    private var loadedGoal: MealGoal?

    private var token: String
    private var userId: UUID?

    init(token: String, userId: UUID?) {
        self.token = token
        self.userId = userId
    }

    @MainActor
    func loadUserTokenAndGoal(token: String) async {
        isLoading = true
        defer { isLoading = false }

        self.token = token

        do {
            let goal = try await MealGoalService.getGoal(token: token)
            self.loadedGoal = goal
            self.kcal = "\(goal.kcalGoal)"
            self.protein = "\(goal.proteinGoal)"
            self.carbs = "\(goal.carbsGoal)"
            self.fat = "\(goal.fatGoal)"
        } catch {
        }
    }

    @MainActor
    func save() async {
        isLoading = true
        defer { isLoading = false }

        guard let kcalInt = Int(kcal),
              let proteinInt = Int(protein),
              let carbsInt = Int(carbs),
              let fatInt = Int(fat) else {
            errorMessage = "All fields must be numbers."
            return
        }

        let goalToSave = MealGoal(
            id: loadedGoal?.id,
            userId: userId ?? UUID(),
            kcalGoal: kcalInt,
            proteinGoal: proteinInt,
            carbsGoal: carbsInt,
            fatGoal: fatInt
        )

        do {
            if loadedGoal != nil {
                loadedGoal = try await MealGoalService.updateGoal(token: token, goal: goalToSave)
            } else {
                loadedGoal = try await MealGoalService.createGoal(token: token, goal: goalToSave)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    @MainActor
    func autoCalc() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let goal = try await MealGoalService.autoCalculate(token: token)
            self.loadedGoal = goal
            self.kcal = "\(goal.kcalGoal)"
            self.protein = "\(goal.proteinGoal)"
            self.carbs = "\(goal.carbsGoal)"
            self.fat = "\(goal.fatGoal)"
        } catch {
            errorMessage = "Could not auto-calculate. User profile is incomplete."
        }
    }
}
