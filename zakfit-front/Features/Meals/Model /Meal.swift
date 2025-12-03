//
//  Meal.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import Foundation

struct Meal: Codable, Identifiable{
    var id: UUID?
    var date: Date
    var userId: UUID
    var mealTypeId: UUID
    var mealItemIds: [UUID]
    var customMealItemIds: [UUID]
    var totalKcal: Int
    var totalProtein: Int
    var totalCarbs: Int
    var totalFat: Int
}
