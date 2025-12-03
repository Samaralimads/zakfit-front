//
//  MealGoal.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import Foundation

struct MealGoal: Codable, Identifiable {
    var id: UUID
    var userId: UUID
    var kcalGoal: Int
    var proteinGoal: Int
    var carbsGoal: Int
    var fatGoal: Int
}
