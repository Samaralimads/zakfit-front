//
//  ActivityGoalService.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 04/12/2025.
//

import Foundation

final class ActivityGoalService {
    
    static let baseURL = "http://127.0.0.1:8080"

    // MARK: - Get current goals
    static func getGoal(token: String) async throws -> ActivityGoal {
        guard let url = URL(string: "\(baseURL)/activity-goals") else { throw URLError(.badURL) }
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, res) = try await URLSession.shared.data(for: req)
        guard let http = res as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let goals = try JSONDecoder().decode([ActivityGoal].self, from: data)
        // Assume we take the first one for the current user
        guard let firstGoal = goals.first else { throw URLError(.fileDoesNotExist) }
        return firstGoal
    }
    
    // MARK: - Create goal
    static func createGoal(token: String, goal: ActivityGoal) async throws -> ActivityGoal {
        guard let url = URL(string: "\(baseURL)/activity-goals") else { throw URLError(.badURL) }
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "activityTypeId": goal.activityTypeId.uuidString,
            "goalType": goal.goalType,
            "amount": goal.amount
        ]
        req.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, res) = try await URLSession.shared.data(for: req)
        guard let http = res as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(ActivityGoal.self, from: data)
    }
    
    // MARK: - Update goal
    static func updateGoal(token: String, goal: ActivityGoal) async throws -> ActivityGoal {
        guard let id = goal.id,
              let url = URL(string: "\(baseURL)/activity-goals/\(id.uuidString)") else { throw URLError(.badURL) }
        
        var req = URLRequest(url: url)
        req.httpMethod = "PATCH"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "activityTypeId": goal.activityTypeId.uuidString,
            "goalType": goal.goalType,
            "amount": goal.amount
        ]
        req.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, res) = try await URLSession.shared.data(for: req)
        guard let http = res as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(ActivityGoal.self, from: data)
    }
    
}

