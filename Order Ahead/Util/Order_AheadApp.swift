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
            ContentView()
            .onOpenURL(perform: { url in
                let stripeHandled = StripeAPI.handleURLCallback(with: url)
                print(url)
                print("YOO")
                if(stripeHandled) {
                    // Redirect to dashboard
                } else {
                    // Not a stripe URL, meant to handle normally
                }
            })
        }
    }
}

