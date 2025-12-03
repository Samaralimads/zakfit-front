//
//  UserService.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import Foundation

// MARK: - Response Models

struct LoginResponse: Codable {
    let token: String
    let user: User
}

struct RegisterResponse: Codable {
    let user: User
    let token: String
}

// MARK: - UserService

final class UserService {
    
    // Base URL for your backend
    static let baseURL = "http://127.0.0.1:8080"
    
    // MARK: - Login
    static func login(email: String, password: String) async throws -> LoginResponse {
        guard let url = URL(string: "\(baseURL)/auth/login") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "email": email,
            "password": password
        ]
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            let message = String(data: data, encoding: .utf8) ?? "Server error"
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
        }
        
        return try JSONDecoder().decode(LoginResponse.self, from: data)
    }
    
    // MARK: - Register
    static func register(firstName: String, lastName: String, email: String, password: String) async throws -> RegisterResponse {
        guard let url = URL(string: "\(baseURL)/auth/register") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password
        ]
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            let message = String(data: data, encoding: .utf8) ?? "Server error"
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
        }
        
        return try JSONDecoder().decode(RegisterResponse.self, from: data)
    }
    
    // MARK: - Get Current User
    static func getCurrentUser(token: String) async throws -> User {
        guard let url = URL(string: "\(baseURL)/users/profile") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(User.self, from: data)
    }
    
    // MARK: - Update Profile
    static func updateProfile(token: String, user: User) async throws -> User {
        guard let url = URL(string: "\(baseURL)/users/profile") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body = [
            "firstName": user.firstName,
            "lastName": user.lastName,
            "email": user.email,
            "age": user.age,
            "heightCm": user.heightCm,
            "weightKg": user.weightKg,
            "gender": user.gender,
            "dietaryPreferences": user.dietaryPreferences
        ] as [String: Any?]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body.compactMapValues { $0 })
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse,
              (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(User.self, from: data)
    }
}
