//
//  AuthDataSource.swift
//  cloudrm
//
//  Created by Jean Laura on 14/01/25.
//

import Foundation
import FirebaseAuth



final class AuthDataSource {
    
    private var delegate = Auth.auth()
    
    func getCurrentUser() -> UserCloud? {
        
        guard let user = delegate.currentUser else {
            return nil
        }
        
        let userCloud = UserCloud(email: user.email ?? "No email")
        return userCloud
    }
    
    func createUserWithEmail(email: String, password: String) async throws -> UserCloud {
        
        let request = try await delegate.createUser(withEmail: email, password: password)
        let email = request.user.email ?? "No email"
        
        let userCloud = UserCloud(email: email)
        
        return userCloud
    }
    
    func loginWithEmail(email: String, password: String) async throws -> UserCloud {
        
        let request = try await delegate.signIn(withEmail: email, password: password)
        let email = request.user.email ?? "No email"
        
        let userCloud = UserCloud(email: email)
        
        return userCloud
    }
    
    func logout() throws {
        try delegate.signOut()
    }
    
}
