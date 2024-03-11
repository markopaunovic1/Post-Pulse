//
//  AuthViewModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-11.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User2?
    
    init() {
        
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        print("Signing in..")
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User2(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("Users").document(user.id).setData(encodedUser)
        } catch {
            print("Failed to create user with error \(error.localizedDescription)")
        }
        
        
        print("Creating user..")
    }
    
    func signOut() {
        print("Signing out..")
    }
    
    func fetchUser() async {
        print("Fetching user..")
    }
    
}
