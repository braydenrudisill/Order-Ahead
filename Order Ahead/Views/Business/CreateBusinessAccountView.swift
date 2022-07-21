//
//  SwiftUIView.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/12/21.
//

import SwiftUI
import FirebaseAuth

struct CreateBusinessAccountView: View {
    @State var email = ""
    @State var password: String = ""
//    @State var redirecting = false
    
    @EnvironmentObject var viewModel: AppViewModel
    
//    @EnvironmentObject var businessListViewModel: BusinessListViewModel
    
    var body: some View {
        VStack {
            // Replace text below with this and create the dashboard !
            //NewBusinessForm(uid: viewModel.auth.currentUser!.uid, menu: typeList, businessListViewModel: businessListViewModel) 
            NavigationLink("", destination: NewBusinessForm(uid: viewModel.auth.currentUser?.uid ?? "no uid", menu: typeList), isActive: $viewModel.signedIn)
            TextField("Email", text: $email)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(1.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(1.0)
                .padding(.bottom, 20)
            
            // Sign up Button
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                viewModel.signUp(email: email, password: password)
            }) {
                ButtonContent(text: "SIGN UP")
            }
            
            // Sign in Button
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                viewModel.signIn(email: email, password: password)
            }) {
                ButtonContent(text: "SIGN IN")
            }
        }
        .padding()
    }
}

struct CreateBusinessAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateBusinessAccountView()
//            .environmentObject(AppViewModel())
    }
}
