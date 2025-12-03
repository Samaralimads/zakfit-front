//
//  User.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID?
    var firstName: String
    var lastName: String
    var email: String
    var age: Int?
    var heightCm: Double?
    var weightKg: Double?
    var gender: String?
    var dietaryPreferences: String?
}
