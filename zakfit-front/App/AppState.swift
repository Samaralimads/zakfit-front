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
    
    private let hasSeenProfileAlertKey = "hasSeenProfileAlert"
    var hasSeenProfileAlert: Bool {
        get { UserDefaults.standard.bool(forKey: hasSeenProfileAlertKey) }
        set { UserDefaults.standard.set(newValue, forKey: hasSeenProfileAlertKey) }
    }

    var isLoggedIn: Bool {
        token != nil && user != nil
    }

    func login(user: User, token: String, isFromRegistration: Bool = false) {
        self.user = user
        self.token = token
        
        if isFromRegistration && !hasSeenProfileAlert {
            showProfileSetupAlert = true
            hasSeenProfileAlert = true
        }
    }
    
    func logout() {
        self.user = nil
        self.token = nil
        showProfileSetupAlert = false
    }
}


