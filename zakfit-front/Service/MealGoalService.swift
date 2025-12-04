//
//  MealGoalService.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 03/12/2025.
//

import Foundation

enum MealGoalServiceError: Error {
    case invalidURL
    case serverError(statusCode: Int)
    case decodingError(Error)
    case unknownError
}

final class MealGoalService {
    
    static let baseURL = "http://127.0.0.1:8080"
    
    // MARK: - Generic request function
    private static func request<T: Decodable>(
        path: String,
        method: String = "GET",
        token: String,
        body: Data? = nil
    ) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            throw MealGoalServiceError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        if let body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse else {
            throw MealGoalServiceError.unknownError
        }
        
        guard (200..<300).contains(http.statusCode) else {
            throw MealGoalServiceError.serverError(statusCode: http.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw MealGoalServiceError.decodingError(error)
        }
    }
    
    // MARK: - Get current goal
    static func getGoal(token: String) async throws -> MealGoal {
        try await request(path: "/meal-goals", token: token)
    }
    
    // MARK: - Create goal
    static func createGoal(token: String, goal: MealGoal) async throws -> MealGoal {
        let body = try JSONEncoder().encode([
            "kcalGoal": goal.kcalGoal,
            "proteinGoal": goal.proteinGoal,
            "carbsGoal": goal.carbsGoal,
            "fatGoal": goal.fatGoal
        ])
        return try await request(path: "/meal-goals", method: "POST", token: token, body: body)
    }
    
    // MARK: - Update goal
    static func updateGoal(token: String, goal: MealGoal) async throws -> MealGoal {
        let body = try JSONEncoder().encode([
            "kcalGoal": goal.kcalGoal,
            "proteinGoal": goal.proteinGoal,
            "carbsGoal": goal.carbsGoal,
            "fatGoal": goal.fatGoal
        ])
        return try await request(path: "/meal-goals", method: "PATCH", token: token, body: body)
    }
    
    // MARK: - Auto-calc using BMR
    static func autoCalculate(token: String) async throws -> MealGoal {
        try await request(path: "/meal-goals/auto", method: "POST", token: token)
    }
}
