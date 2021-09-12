//
//  ItemListFormView.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/11/21.
//

import SwiftUI

struct ItemListFormView: View {
    @Binding var itemList: ItemList
    @State var newItemName: String = ""
    var body: some View {
        let ilProxy = Binding(get: {itemList}, set: { new in
            itemList = new
        })
        Section(header: ListHeader(itemList: ilProxy)) {
            // Loop through each item and display it with an ItemFormView (textfield)
            ForEach(itemList.list) { item in
                let proxy = Binding(get: {item}, set: { new in
                    let idx = itemList.list.firstIndex(where: {
                        $0.id == item.id
                    })!
                    itemList.list[idx] = new
                })
                ItemFormView(item: proxy)
            }
            TextField("New Item:", text: $newItemName, onCommit: {
                //When the user commits add to array and clear the new item variable
                itemList.list.append(ItemModel(name: newItemName, ingredients: "Milk, Soy, Chocolate", itemArtString: "c-milk-tea", price:699))
                newItemName = ""
            })
        }
    }
}
struct ListHeader: View {
    @State var editing: String = ""
    @Binding var itemList: ItemList
    
    var body: some View{
        TextField(itemList.name, text: $editing, onCommit: {
            itemList.name = editing
        })
        .foregroundColor(.black)
    }
}
struct ItemFormView: View {
    @State var editing: String = ""
    @Binding var item: ItemModel
    
    var body: some View{
        TextField(item.name, text: $editing, onCommit: {
            item.name = editing
        })
        .foregroundColor(.black)
    }
}
//struct ItemListFormView_Previews: PreviewProvider {
//  static var previews: some View {
//    ItemListFormView(itemList: typeList)
//  }
//}
