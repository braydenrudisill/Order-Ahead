//
//  ItemListView.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 8/29/21.
//

import SwiftUI

struct ItemListView: View {
    var itemlist: ItemList
    var body: some View {
        VStack {
            Text(itemlist.name)
                .font(.largeTitle)
                .bold()
            ScrollView(.vertical) {
                VStack(spacing: 7) {
                    ForEach(itemlist.list, id: \.id) { item in
                        ItemCard(item: item)
                    }
                }.frame(height: 400)
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
