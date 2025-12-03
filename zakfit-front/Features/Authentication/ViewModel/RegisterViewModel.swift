//
//  RegisterViewModel.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

@Observable
final class RegisterViewModel {

    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""

    var errorMessage: String?
    var isLoading: Bool = false


    private func validateFields() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }

        guard password == confirmPassword else {
            errorMessage = "The passwords do not match."
            return false
        }

        return true
    }

    @MainActor
    func register(appState: AppState) async {
        guard validateFields() else { return }

        isLoading = true
        errorMessage = nil

        do {
            let response = try await UserService.register(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password
            )

            appState.login(user: response.user, token: response.token)

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

