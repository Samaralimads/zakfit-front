//
//  ActivityGoal.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import Foundation

struct ActivityGoal: Codable, Identifiable {
    var id: UUID?
    var userId: UUID
    var activityTypeId: UUID
    var activityTypeName: String
    var goalType: String
    var amount: Int
}

