//
//  TypeListView.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 8/29/21.
//

import SwiftUI

struct TypeListView: View {
    @EnvironmentObject var business: Business
    @EnvironmentObject var cart: OrderModel
    @State var toCart = false
    var body: some View {
        VStack(spacing: 7) {
            ForEach(0 ..< business.menu.count/2) { i in
                HStack(spacing: 7) {
                    
                    TypeCard(itemlist: business.menu[2*i])
                    TypeCard(itemlist: business.menu[2*i+1])
                }
            }
            if(typeList.count%2==1) {
                TypeCard(itemlist: business.menu[business.menu.count-1])
            }
        }
    }
}

struct TypeListView_Previews: PreviewProvider {
    static var previews: some View {
        TypeListView()
    }
}
