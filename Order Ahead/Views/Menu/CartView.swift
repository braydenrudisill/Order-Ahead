//
//  CartView.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 1/29/22.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: OrderModel
    @State var selectedItem = ItemModel()
    var business: Business
    
    var body: some View {
        Text("ID \(cart.businessId)")
        Text("Current Order:")
        ForEach(cart.items) { item in
            HStack {
                Button(item.name, action: {
                    selectedItem = item
                })
                if (item == selectedItem) {
                    Button("Remove item", action: {
                        cart.remove(item: item)
                        selectedItem = ItemModel()
                    })
                    
                }
            }
            
        }
        NavigationLink(destination: StripeCard(business:business, order:cart)) {
            ButtonContent(text: "Checkout")
        }
        
    }
}

//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//    }
//}
