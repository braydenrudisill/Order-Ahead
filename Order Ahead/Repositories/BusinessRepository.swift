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
    // 1
    authenticationService.$user
      .compactMap { user in
        user?.uid
      }
      .assign(to: \.userId, on: self)
      .store(in: &cancellables)

    // 2
    authenticationService.$user
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        // 3
        self?.get()
      }
      .store(in: &cancellables)
  }

  func get() {
    // 3
    store.collection(path)
      .whereField("userId", isEqualTo: userId)
      .addSnapshotListener { querySnapshot, error in
        // 4
        if let error = error {
          print("Error getting businesses: \(error.localizedDescription)")
          return
        }

        // 5
        self.businesses = querySnapshot?.documents.compactMap { document in
          // 6
          try? document.data(as: Business.self)
        } ?? []
      }
  }

  // 4
  func add(_ business: Business) {
    do {
      var newBusiness = business
      newBusiness.userId = userId
      _ = try store.collection(path).addDocument(from: newBusiness)
    } catch {
      fatalError("Unable to add business: \(error.localizedDescription).")
    }
  }

  func update(_ business: Business) {
    // 1
    guard let businessId = business.id else { return }

    // 2
    do {
      // 3
      try store.collection(path).document(businessId).setData(from: business)
    } catch {
      fatalError("Unable to update business: \(error.localizedDescription).")
    }
  }

  func remove(_ business: Business) {
    // 1
    guard let businessId = business.id else { return }

    // 2
    store.collection(path).document(businessId).delete { error in
      if let error = error {
        print("Unable to remove business: \(error.localizedDescription)")
      }
    }
  }
}
