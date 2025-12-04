//
//  ActivityService.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 04/12/2025.
//

import Foundation

final class ActivityService {

    static let baseURL = "http://127.0.0.1:8080"

    // MARK: - Get all activities for the user
    static func getAll(token: String) async throws -> [Activity] {
        guard let url = URL(string: "\(baseURL)/activities") else { throw URLError(.badURL) }

        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, res) = try await URLSession.shared.data(for: req)
        
        guard let http = res as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }


        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode([Activity].self, from: data)
    }

    // MARK: - Get one activity by ID
    static func getById(token: String, id: UUID) async throws -> Activity {
        guard let url = URL(string: "\(baseURL)/activities/\(id.uuidString)") else { throw URLError(.badURL) }

        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, res) = try await URLSession.shared.data(for: req)
        guard let http = res as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(Activity.self, from: data)
    }

    // MARK: - Create activity
    static func create(token: String, activity: Activity) async throws -> Activity {
        guard let url = URL(string: "\(baseURL)/activities") else { throw URLError(.badURL) }

        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = [
            "date": ISO8601DateFormatter().string(from: activity.date),
            "duration": activity.duration,
            "caloriesBurned": activity.caloriesBurned,
            "activityTypeId": activity.activityTypeId.uuidString
        ]
        req.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, res) = try await URLSession.shared.data(for: req)
        guard let http = res as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(Activity.self, from: data)
    }

    // MARK: - Update activity
    static func update(token: String, activity: Activity) async throws -> Activity {
        let url = URL(string: "\(baseURL)/activities/\(activity.id.uuidString)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(activity)

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(Activity.self, from: data)
    }


    // MARK: - Delete activity
    static func delete(token: String, id: UUID) async throws {
        guard let url = URL(string: "\(baseURL)/activities/\(id.uuidString)") else { throw URLError(.badURL) }

        var req = URLRequest(url: url)
        req.httpMethod = "DELETE"
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (_, res) = try await URLSession.shared.data(for: req)
        guard let http = res as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }

    // MARK: - Get all activity types
    static func getTypes() async throws -> [ActivityType] {
        guard let url = URL(string: "\(baseURL)/activity-types") else { throw URLError(.badURL) }

        let (data, res) = try await URLSession.shared.data(from: url)
        guard let http = res as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([ActivityType].self, from: data)
    }
}
