//
//  MealService.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 04/12/2025.
//

import Foundation

// MARK: - Request DTOs

struct MealItemSearchRequest: Codable {
    let query: String
}

struct AddMealItemRequest: Codable {
    let mealId: UUID
    let mealItemId: UUID?
    let customItemId: UUID?
    let quantity: Double
}

// MARK: - MealService

final class MealService {

    static let baseURL = "http://127.0.0.1:8080"

    // MARK: - Get Meal Types
    static func getMealTypes(token: String) async throws -> [MealType] {
        guard let url = URL(string: "\(baseURL)/meal-types") else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse,
              (200..<300).contains(http.statusCode) else { throw URLError(.badServerResponse) }

        return try JSONDecoder().decode([MealType].self, from: data)
    }

    // MARK: - Get Meals
    static func getMeals(token: String) async throws -> [Meal] {
        guard let url = URL(string: "\(baseURL)/meals") else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse,
              (200..<300).contains(http.statusCode) else { throw URLError(.badServerResponse) }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601   

        return try decoder.decode([Meal].self, from: data)
    }

    // MARK: - Get Meal Items
    static func getMealItems(token: String) async throws -> [MealItem] {
        guard let url = URL(string: "\(baseURL)/meal-items") else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse,
              (200..<300).contains(http.statusCode) else { throw URLError(.badServerResponse) }

        return try JSONDecoder().decode([MealItem].self, from: data)
    }


    // MARK: - Get Custom Meal Items
    static func getCustomMealItems(token: String) async throws -> [CustomMealItem] {
        guard let url = URL(string: "\(baseURL)/custom-meal-items") else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse,
              (200..<300).contains(http.statusCode) else { throw URLError(.badServerResponse) }

        return try JSONDecoder().decode([CustomMealItem].self, from: data)
    }


//    // MARK: - Search Items
//    static func searchMealItems(token: String, query: String) async throws -> [MealItem] {
//        guard let url = URL(string: "\(baseURL)/mealItems/search") else { throw URLError(.badURL) }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let body = MealItemSearchRequest(query: query)
//        request.httpBody = try JSONEncoder().encode(body)
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//        
//
//        guard let http = response as? HTTPURLResponse,
//              (200..<300).contains(http.statusCode) else { throw URLError(.badServerResponse) }
//
//        return try JSONDecoder().decode([MealItem].self, from: data)
//    }


    // MARK: - Add Item to Meal
    static func addItemToMeal(token: String, req: AddMealItemRequest) async throws {
        guard let url = URL(string: "\(baseURL)/meal-items") else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(req)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse,
              (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
    
    // MARK: - Add Custom Item to Meal
    static func addCustomItemToMeal(token: String, req: AddMealItemRequest) async throws {
        guard let url = URL(string: "\(baseURL)/custom-meal-items") else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(req)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse,
              (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
