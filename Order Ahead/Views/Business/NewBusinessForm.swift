// Copyright (c) 2020 Razeware LLC
import Foundation
import SwiftUI
import Combine

struct Data: Decodable {
    public var url: String
}

struct NewBusinessForm: View {
    var uid: String
    @State private var response_data: Data = Data(url: "")
    @State private var name: String = ""
    @State private var newType: String = ""
    @State var menu: [ItemList]
    @Environment(\.openURL) var openURL
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Name")
                    .foregroundColor(.gray)
                TextField("Enter the name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            List{
//                This particular setup is for Swift 5.5+
//                ForEach($menu) { $itemList in
//                    ItemListView(itemList: $itemList)
//                }
//                This should do the same thing but works below 5.5
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
        let business = Business(uid: uid, name: name, menu: menu)
        print("Business (newbusform) \(business.name)")
        let documentID: String = viewModel.businessListViewModel.add(business)
        presentationMode.wrappedValue.dismiss()
        // HTTP Request Parameters which will be sent in HTTP Request Body
        
//        let postString = "firestoreID=\(documentID)"
        // print("\(business)")
        // try to get the id of the firestore document somehow and put it in postString AAAAAAAA
        
        
        guard let url = URL(string: "http://localhost:4242/create-express-account") else { return }
        
        let body: [String: String] = ["firestoreID": documentID]
        
        print("Post string: \(body)")
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let todoData = data {
                    print(data!)
                    // 3.
                    let decodedData = try JSONDecoder().decode(Data.self, from: todoData)
                    DispatchQueue.main.async {
                        print(decodedData)
                        self.response_data = decodedData
                        
                        // Redirect to safari for stripe connect setup
                        if let url = URL(string: self.response_data.url) {
                            UIApplication.shared.open(url)
                        }
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Error")
            }
        }.resume()
    }
    
    private func addType() {
        self.menu.append(ItemList(name: newType, picture: "c-milk-tea", list: []))
    }
}



struct NewBusinessForm_Previews: PreviewProvider {
  static var previews: some View {
    NewBusinessForm(uid: "", menu: typeList)
  }
}
