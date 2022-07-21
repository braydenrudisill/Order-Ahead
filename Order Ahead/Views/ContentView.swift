//
//  ContentView.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/6/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var selected = "";
    
    var body: some View {
        
//        StripeCard()
        if selected=="user" {
            NavigationView {
                BusinessListView()
            }
        }

        else if selected=="business" {
            NavigationView{
                if (viewModel.signedIn && viewModel.business.uid != "") {
                    Dashboard()
                } else if viewModel.signedIn {
                    VStack{
                    NewBusinessForm(uid: viewModel.auth.currentUser!.uid, menu: typeList)
                    Text("id\(viewModel.business.uid)")
                    }
                } else {
                    CreateBusinessAccountView()
                }
            }
            .onAppear {
                viewModel.signedIn = viewModel.isSignedIn

                if (viewModel.signedIn) {
                    viewModel.businessListViewModel.businessRepository.store.collection("businesses").whereField("uid", isEqualTo: viewModel.auth.currentUser!.uid)
                        .getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("❌ Error getting businesses: \(err)")
                            } else {
                                for document in querySnapshot!.documents {
                                    viewModel.business = try! document.data(as: Business.self)!
                                    print("Just fetched \(viewModel.business.name)")
                                }
                            }
                        }
                }
                print("Signed in: \(viewModel.auth.currentUser?.email ?? "False")")
            }
        }
        else {
            Button(action: {
                selected="user";
            }) { Text("User") }
            Button(action: {
                selected="business";
            }) { Text("Business") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// OLD TESTING
//            BusinessListView(businessListViewModel: BusinessListViewModel())
//            NewBusinessForm(businessListViewModel: BusinessListViewModel())
//            NewBusinessForm(menu: typeList, businessListViewModel: BusinessListViewModel())

// SIGN OUT
//                VStack {
//                    Text("Signed in as \(viewModel.auth.currentUser!.email ?? "unknown email")!")
//                    Button(action: {
//                        viewModel.signOut()
//                    }) {
//                        ButtonContent(text: "SIGN OUT")
//                    }
//                }
