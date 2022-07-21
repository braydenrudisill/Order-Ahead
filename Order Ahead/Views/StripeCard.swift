//
//  StripeCard.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/5/21.
//

import SwiftUI
import Stripe
import FirebaseFirestore
// todo, make the business an environment variable like the viewmodel in content view

struct StripeCard: View {
    var business: Business
    @ObservedObject var model = BackendModel()
    @State var loading = false
    @State var paymentMethodParams: STPPaymentMethodParams?
    @State var showingAlert = false
    var order: OrderModel
    let ref = Firestore.firestore()
    
    
    var body: some View {
        VStack {
            STPPaymentCardTextField
                .Representable(paymentMethodParams: $paymentMethodParams)
                .padding()
            if let paymentIntent = model.paymentIntentParams {
                Button("Order"){
                    paymentIntent.paymentMethodParams = paymentMethodParams
                    loading = true
                }
                .paymentConfirmationSheet(isConfirmingPayment: $loading, paymentIntentParams: paymentIntent, onCompletion: model.onCompletion)
                .disabled(loading)
            } else {
                Text("Loading...")
            }
            // pay button
        }.onAppear {
            print("Preparing to send to stripe account id \(business.stripeaccountid)")
            model.preparePaymentIntent(paymentMethodType: "card", currency: "usd", connectedAccID: business.stripeaccountid)
        }
        
        if let paymentStatus = model.paymentStatus {
            HStack {
                switch paymentStatus {
                case .succeeded:
                    Text("Payment complete!")
                        .onAppear(){
                            sendOrder()
                        }
                case .failed:
                    Text("Payment failed!")
                case .canceled:
                    Text("Payment canceled!")
                @unknown default:
                    Text("Unknown status!")
                }
            }
        }
    }
    
    func sendOrder() {
        let _ = try? ref.collection("orders").addDocument(from: order) { (err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
        }
        
        showingAlert = true
    }
}

//struct StripeCard_Previews: PreviewProvider {
//    static var previews: some View{
//        StripeCard(item: ItemModel())
//    }
//}
