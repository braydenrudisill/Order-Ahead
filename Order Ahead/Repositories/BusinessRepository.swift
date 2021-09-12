//
//  BusinessRepository.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/7/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class BusinessRepository: ObservableObject {
  private let path: String = "businesses"
  private let store = Firestore.firestore()

  @Published var businesses: [Business] = []

  var userId = ""
  private let authenticationService = AuthenticationService()
  private var cancellables: Set<AnyCancellable> = []

  init() {
    
    authenticationService.$user
      .compactMap { user in
        user?.uid
      }
      .assign(to: \.userId, on: self)
      .store(in: &cancellables)

    
    authenticationService.$user
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        
        self?.get()
      }
      .store(in: &cancellables)
    
  }

  func get() {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        
        if let error = error {
          print("❌ Error getting businesses: \(error.localizedDescription)")
          return
        }

        
        self.businesses = querySnapshot?.documents.compactMap { document in
          
          try? document.data(as: Business.self)
        } ?? []
      }
  }

  
  func add(_ business: Business) {
    do {
      let newBusiness = business
      _ = try store.collection(path).addDocument(from: newBusiness)
    } catch {
      fatalError("❌ Unable to add business: \(error.localizedDescription).")
    }
  }

  func update(_ business: Business) {
    
    guard let businessId = business.id else { return }

    
    do {
      
      try store.collection(path).document(businessId).setData(from: business)
    } catch {
      fatalError("❌ Unable to update business: \(error.localizedDescription).")
    }
  }

  func remove(_ business: Business) {
    
    guard let businessId = business.id else { return }

    
    store.collection(path).document(businessId).delete { error in
      if let error = error {
        print("❌ Unable to remove business: \(error.localizedDescription)")
      }
    }
  }
}
