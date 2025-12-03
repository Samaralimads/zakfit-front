//
//  LoginViewModel.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

@Observable
final class LoginViewModel {

    var email: String = ""
    var password: String = ""
    var errorMessage: String?
    var isLoading: Bool = false

    private func validateFields() -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Veuillez remplir tous les champs."
            return false
        }
        return true
    }

    @MainActor
    func login(appState: AppState) async {
        guard validateFields() else { return }

        isLoading = true
        errorMessage = nil

        do {
            let response = try await UserService.login(email: email, password: password)
            appState.login(user: response.user, token: response.token)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
