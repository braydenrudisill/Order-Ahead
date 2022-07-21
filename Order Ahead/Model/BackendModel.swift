//
//  BackendModel.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/5/21.
//

import Foundation
import Stripe

class BackendModel: ObservableObject {
    @Published var paymentStatus: STPPaymentHandlerActionStatus?
    @Published var paymentIntentParams: STPPaymentIntentParams?
    @Published var lastPaymentError: NSError?
    var paymentMethodType: String?
    var currency: String?
    var connectedAccID: String?
    
    func preparePaymentIntent(paymentMethodType: String, currency: String, connectedAccID: String) {
        self.paymentMethodType = paymentMethodType
        self.currency = currency
        self.connectedAccID = connectedAccID
        
        let url = URL(string: BackendUrl + "create-payment-intent")!
        var request = URLRequest(url: url)
        let json: [String: Any] = [
            "paymentMethodType": paymentMethodType,
            "currency": currency,
            "connectedAccID": connectedAccID,
        ]
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data,response, error) in
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let clientSecret = json["clientSecret"] as? String
            else {
                let message = error?.localizedDescription ?? "Failed to decode response from server"
                print("❌ \(message)")
                return
            }
            print("💸 Created the PaymentIntent \(clientSecret)")
            DispatchQueue.main.async {
                self.paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
            }
        })
        task.resume()
    }
    
    
    func onCompletion(status: STPPaymentHandlerActionStatus, pi: STPPaymentIntent?, error: NSError?) {
        self.paymentStatus = status
        self.lastPaymentError = error
        if let e = (error) { print("❌ Error: \(e)") }
        
        if status == .succeeded {
            self.paymentIntentParams = nil
            preparePaymentIntent(paymentMethodType: self.paymentMethodType!, currency: self.currency!, connectedAccID: self.connectedAccID!)
        }
    }
}
