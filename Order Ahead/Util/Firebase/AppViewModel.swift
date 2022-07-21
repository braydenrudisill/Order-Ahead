//
//  SessionStore.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/12/21.
//

import SwiftUI
import FirebaseAuth
import Combine

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    
    @Published var businessListViewModel: BusinessListViewModel = BusinessListViewModel()
    @Published var business: Business = Business()
    @Published var setUp = false
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else { return }
            // On success
            DispatchQueue.main.async {
                self?.signedIn = true
                print("👋 Signing in")
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else { return }
            // Success
            DispatchQueue.main.async {
                self?.signedIn = true
                print("👋 Signed up")
            }
        }
    }
    
    func signOut() {
        guard isSignedIn else {
            print("Can't sign out when nobody's signed in")
            return
        }
        do {
            try auth.signOut()
            self.signedIn = false
            business = Business()
            print("👋 Signing out")
        }
        catch {
            print("❌ Error while signing out")
        }
    }
}
