//
//  ProfileViewModel.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 03/12/2025.
//

import Foundation
import SwiftUI

@Observable
class ProfileViewModel {

    var user: User?

    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var age: String = ""
    var height: String = ""
    var weight: String = ""

    var gender: String = ""
    let genderOptions = ["Male", "Female"]

    var dietary: String = ""
    let dietaryOptions = ["Vegetarian", "Vegan", "Pescetarian", "Gluten Free", "None"]

    var showGenderPicker = false
    var showDietaryPicker = false

    var isLoading = false
    var errorMessage: String?
    
    func loadUser(token: String) async {
        isLoading = true
        defer { isLoading = false }

        do {
            let fetchedUser = try await UserService.getCurrentUser(token: token)
            await MainActor.run {
                self.user = fetchedUser
                self.firstName = fetchedUser.firstName
                self.lastName = fetchedUser.lastName
                self.email = fetchedUser.email
                self.age = fetchedUser.age?.description ?? ""
                self.height = fetchedUser.heightCm?.description ?? ""
                self.weight = fetchedUser.weightKg?.description ?? ""
                self.gender = fetchedUser.gender ?? ""
                self.dietary = fetchedUser.dietaryPreferences ?? ""
            }
        } catch {
            await MainActor.run { self.errorMessage = error.localizedDescription }
        }
    }

    @MainActor
    func updateProfile(token: String) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let updatedUser = User(
                firstName: firstName,
                lastName: lastName,
                email: email,
                age: Int(age),
                heightCm: Double(height),
                weightKg: Double(weight),
                gender: gender,
                dietaryPreferences: dietary
            )

            let savedUser = try await UserService.updateProfile(token: token, user: updatedUser)

            self.user = savedUser
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
