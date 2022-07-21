//
//  Order_AheadApp.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 8/29/21.
//

import SwiftUI
import Stripe
import Firebase
import FirebaseFunctions

let BackendUrl = "http://127.0.0.1:4242/"

@main
struct Order_AheadApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
        let url = URL(string: BackendUrl + "config")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data,response, error) in
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let publishableKey = json["publishableKey"] as? String
            else {
                print("❌ Failed to retrieve publishable key from server")
                return
            }
            print("🔑 Fetched the publishable key \(publishableKey)")
            StripeAPI.defaultPublishableKey = publishableKey
        })
        task.resume()
    }
    
    
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
//            let businessListViewModel = BusinessListViewModel()
            ContentView()
                .environmentObject(viewModel)
//                .environmentObject(businessListViewModel)
                .onOpenURL(perform: { url in
                    let stripeHandled = StripeAPI.handleURLCallback(with: url)
                    print("stripehandled? \(stripeHandled)")
                    print("YOO")
                    viewModel.businessListViewModel.businessRepository.store.collection("businesses").whereField("uid", isEqualTo: viewModel.auth.currentUser!.uid)
                        .getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("❌ Error getting businesses: \(err)")
                            } else {
                                for document in querySnapshot!.documents {
                                    viewModel.business = try! document.data(as: Business.self)!
                                    print("Just fetched \(viewModel.business.name)")
                                }
                            }
                        }
                    if(stripeHandled) {
                        
                        print("Setup: \(viewModel.setUp)")
                        print("Signed in: \(viewModel.signedIn)")
                    } else {
                        // Not a stripe URL, meant to handle normally
                    }
                })
        }
    }
}

