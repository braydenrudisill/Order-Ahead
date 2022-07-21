//
//  Dashboard.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 10/8/21.
//

import SwiftUI
import FirebaseFirestore

struct Dashboard: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var orders: [OrderModel] = []
    var uid: String {
        return viewModel.auth.currentUser!.uid
    }
    let ref = Firestore.firestore()
    var body: some View {
        VStack{
            Text("Welcome to the business dashboard !")
            Text("Current user: \(viewModel.auth.currentUser?.email ?? "No email found")")
            Text("Name: \(viewModel.business.name)")
            
            Button(action: {
                viewModel.signOut()
            }) {
                Text("SIGN OUT")
            }
            VStack {
                Text("Orders")
                    .font(.largeTitle)
                    .bold()
                ScrollView(.vertical) {
                    VStack(spacing: 7) {
                        ForEach(orders, id: \.id) { order in
                            ForEach(order.items, id: \.id) {item in
                                Text("\(item.name) : \(order.id ?? "")")
                            }
                        }
                    }.frame(height: 400)
                }
            }
        }
        .onAppear {
            checkAllOrders()
        }
    }
    
    func checkAllOrders() {
        ref.collection("orders").addSnapshotListener { (snap, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            guard let data = snap else { return }
            
            data.documentChanges.forEach { (doc) in
                print("Data!! \n\n \(doc.document.data())\n\n")
                if doc.type == .added {
                    var order = OrderModel()
                    do {
                        order = try doc.document.data(as: OrderModel.self)!
                    }
                    catch {
                        return // continue doesn't detect loop?
                    }
                    
                    guard order.businessId == viewModel.business.uid else { return }
                    DispatchQueue.main.async {
                        self.orders.append(order)
                    }
                }
                else {
                    print(doc.type)
                }
            }
        }
    }
}

//struct Dashboard_Previews: PreviewProvider {
//    static var previews: some View {
//        Dashboard(viewModel: AppViewModel())
//    }
//}
