//
//  StripeCard.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/5/21.
//

import SwiftUI
import Stripe

struct StripeCard: View {
    @ObservedObject var model = BackendModel()
    @State var loading = false
    @State var paymentMethodParams: STPPaymentMethodParams?
    
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
            model.preparePaymentIntent(paymentMethodType: "card", currency: "usd", connectedAccID: "acct_1JWwXy2fR3SCGSyZ")
        }
        
        if let paymentStatus = model.paymentStatus {
            HStack {
                switch paymentStatus {
                case .succeeded:
                    Text("Payment complete!")
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
}

struct StripeCard_Previews: PreviewProvider {
    static var previews: some View{
        StripeCard()
    }
}
