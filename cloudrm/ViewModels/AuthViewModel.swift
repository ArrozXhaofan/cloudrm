//
//  AuthViewModel.swift
//  cloudrm
//
//  Created by Jean Laura on 14/01/25.
//

import Foundation
import SwiftUI

@Observable
final class AuthViewModel {
    
    private let authService: AuthDataSource
    
    var userCloud: UserCloud?
    var error: Error?
    
    init(authService: AuthDataSource = AuthDataSource()) {
        self.authService = authService
        getCurrentUser()
    }
    
    func createNewUser(email: String, password: String) async  {
        
        do {
            let user = try await authService.createUserWithEmail(email: email, password: password)
            self.userCloud = user
            
            error = nil
            
        } catch {
            self.error = error
        }
    }
    
    func login(email: String, password: String) async  {
        
        do {
            let user = try await authService.loginWithEmail(email: email, password: password)
            self.userCloud = user
            
            error = nil
            
        } catch {
            self.error = error
        }
    }
    
    func getCurrentUser() {
        self.userCloud = authService.getCurrentUser()
    }
    
    func signOut() {
        do {
            try authService.logout()
            self.userCloud = nil
            
        } catch  {
            self.error = error
        }
    }
}

struct AuthViewModelKey: EnvironmentKey {
    static let defaultValue: AuthViewModel = AuthViewModel()
}

extension EnvironmentValues {
    var authViewModel: AuthViewModel {
        get { self[AuthViewModelKey.self] }
        set { self[AuthViewModelKey.self] = newValue }
    }
}
