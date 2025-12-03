//
//  AppState.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

@Observable
final class AppState {
    var token: String?
    var user: User?
    
    var showProfileSetupAlert: Bool = false

    var isLoggedIn: Bool {
        token != nil && user != nil
    }

    func login(user: User, token: String) {
        self.user = user
        self.token = token
        
        self.showProfileSetupAlert = true
    }
    
    func logout() {
        self.user = nil
        self.token = nil
        self.showProfileSetupAlert = false
    }
}


