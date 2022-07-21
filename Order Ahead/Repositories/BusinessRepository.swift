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
    private static var numInstances = 0
    private let path: String = "businesses"
    public let store = Firestore.firestore()

    @Published var businesses: [Business] = []

    var userId = ""
    public var authenticationService: AuthenticationService = AuthenticationService()
    private var cancellables: Set<AnyCancellable> = []

    init() {
        BusinessRepository.numInstances += 1
        print("Number of repositories: \(BusinessRepository.numInstances)")
        
        authenticationService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)

        // this below bit runs twice for some reason /shrug
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
            
            print("\(self.businesses.count) businesses fetched")
        }
    }
    
    // doesn't really work, just copy paste this wherever we need it "thumbsup"
//    func search(uid: String) -> Business {
//        var business: Business = Business(uid: "", name: "", menu: [])
//        store.collection("businesses").whereField("uid", isEqualTo: uid)
//        .getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("❌ Error getting businesses: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    business = try! document.data(as: Business.self)!
//                    print("Just fetched \(business.name)")
//                }
//            }
//        }
//        print("Returning \(business.name)")
//        return business
//    }
  
  func add(_ business: Business) -> String {
    do {
        let newBusiness = business
        var ref: DocumentReference? = nil
        ref = try store.collection(path).addDocument(from: newBusiness)
        print("Document added with ID: \(ref!.documentID)")
        return ref!.documentID
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
