//
//  CustomMealItem.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import Foundation

struct CustomMealItem: Codable, Identifiable {
    var id: UUID?
    var name: String
    var servingSize: Int
    var servingUnit: String
    var kcalServing: Int
    var proteinServing: Int
    var carbsServing: Int
    var fatServing: Int
}
