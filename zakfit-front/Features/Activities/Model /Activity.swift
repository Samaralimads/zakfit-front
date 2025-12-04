//
//  Activity.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import Foundation

struct Activity: Codable, Identifiable {
    var id: UUID
    var date: Date
    var duration: Int
    var caloriesBurned: Int
    var activityTypeId: UUID
    var activityTypeName: String
    var userId: UUID
}
