//
//  ItemListView.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 8/29/21.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var business: Business
    @EnvironmentObject var cart: OrderModel
    @State var toCart = false
    var itemlist: ItemList

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Text(itemlist.name)
                    .font(.largeTitle)
                    .bold()
                ScrollView(.vertical) {
                    VStack(spacing: 7) {
                        ForEach(itemlist.list, id: \.id) { item in
                            Button(action: {cart.items.append(item); print("Just added \(item.name)")}){ItemCard(item: item)}
                        }
                    }.frame(height: 400)
                }
            }
            NavigationLink(destination: CartView(business:business).environmentObject(cart)) {
                ZStack{
                    Circle()
                    .fill(Color( red: 54/255, green: 60/255, blue: 50/255, opacity: 1))
                    .frame(width: 80, height: 80)
                    Image("coffee")
                    .resizable()
                        .colorInvert()
                    .frame(width: 70, height: 70)
                }
                .padding()
            }
        }
    }
}

struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(itemlist: milkList)
        ItemListView(itemlist: teaList)
    }
}
