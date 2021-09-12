// Copyright (c) 2020 Razeware LLC

import SwiftUI

struct NewBusinessForm: View {
    @State private var name: String = ""
    @State private var newType: String = ""
    @State var menu: [ItemList]
    @Environment(\.openURL) var openURL
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var businessListViewModel: BusinessListViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Name")
                    .foregroundColor(.gray)
                TextField("Enter the name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
//            HStack{
//                Spacer()
//                Button (action: {
//                    self.addType()
//                }){
//                    Image(systemName: "plus")
//                }
//            }
            List{
    //            This particular setup is for Swift 5.5+
    //            ForEach($menu) { $itemList in
    //                ItemListView(itemList: $itemList)
    //            }
                ForEach(menu) { itemList in
                    let proxy = Binding(get: {itemList}, set: { new in
                        let idx = menu.firstIndex(where: {
                            $0.id == itemList.id
                        })!
                        menu[idx] = new
                    })
                    ItemListFormView(itemList: proxy)
                }
                TextField("New Type:", text: $newType, onCommit: addType)
            }

            Button(action: addBusiness) {
                Text("Add New Business")
                  .foregroundColor(.blue)
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 80, leading: 40, bottom: 0, trailing: 40))
    }

    private func addBusiness() {
        let business = Business( name: name, menu: menu )
        businessListViewModel.add(business)
        presentationMode.wrappedValue.dismiss()
        openURL(URL(string: "http://localhost:4242/create-express-account")!)
    }
    
    private func addType() {
        self.menu.append(ItemList(name: newType, picture: "c-milk-tea", list: []))
    }
//    private func addItem(id: Int, name: String) {
//        self.menu[id].list.append(Item(name: name, ingredients: "Milk, Soy, Chocolate", itemArtString: "c-milk-tea", price:699))
//    }
}

struct NewBusinessForm_Previews: PreviewProvider {
  static var previews: some View {
    NewBusinessForm(menu: typeList, businessListViewModel: BusinessListViewModel())
  }
}
