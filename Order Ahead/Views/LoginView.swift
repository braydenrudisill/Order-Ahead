//
//  LoginView.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 8/31/21.
//

import SwiftUI
import Firebase
import Stripe

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct LoginView : View {
    @State var profile = Profile.default
    @State var db = Firestore.firestore()
    @State var publishable_key: String? = StripeAPI.defaultPublishableKey
    @State var password: String = ""
    @State var isFocused = false
    @State var showAlert = false
    @State var alertMessage = "Something went wrong."
    @State var isLoading = false
    @State var isSuccessful = false
    @State var isRedirecting = false
    
    @EnvironmentObject var viewModel: AppViewModel
    
    func login() {
        self.hideKeyboard()
        self.isFocused = false
        self.isLoading = true
        viewModel.signIn(email: profile.email, password: password)
        
        
        // TODO maybe instead of all this we could have a set of states in the view model like signedIn
        // but for isLoading or hasErrored?
        
        // or could also try returning a result / error so we can handle it the same way here
        // either one lol i'll have to see
        
//        Auth.auth().signIn(withEmail: profile.email, password: password) { (result, error) in
//            self.isLoading = false
//            if error != nil {
//                self.alertMessage = error?.localizedDescription ?? ""
//                self.showAlert = true
//            } else {
//                print("Login!")
//                self.isSuccessful = true
//            }
//        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder .resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack {
            VStack {
                WelcomeText()
                UserImage()
                TextField("Email", text: $profile.email)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(1.0)
                    .padding(.bottom, 20)
                SecureField("Password", text: $password)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(1.0)
                    .padding(.bottom, 20)
                Button(action: { login() }) {
                    ButtonContent(text: "LOGIN")
                }
                .padding(.bottom, 120)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            if isSuccessful {
                ZStack {
                    Color.white
                    VStack {
                        Text("Successfully Logged In!")
                        Spacer()
                        Button(action: {
                            self.isSuccessful = false
                            self.isRedirecting = true
                        }, label: {
                            Text("Continue")
                        })
                    }.padding()
                }
                .frame(width: 300, height: 200)
                .cornerRadius(20).shadow(radius: 20)
                .padding(.bottom, 100)
            } else if isLoading {
                ZStack {
                    Color.white
                    VStack {
                        Text("Logging in...")
                        Spacer()
                    }.padding()
                }
                .frame(width: 300, height: 200)
                .cornerRadius(20).shadow(radius: 20)
                .padding(.bottom, 100)
            }
            
            // maybe we could have a document of all the business account names and everyone else would just be a user
            // loop through that documents names
            // if the uid is on there, redirect to the dashboard / newbusinessform setup thing
            // if not go to the normal business list view or like a home view or smth
            NavigationLink("", destination: NewBusinessForm(uid: viewModel.auth.currentUser?.uid ?? "no uid", menu: typeList), isActive: $viewModel.signedIn)
//            NavigationLink("", destination: BusinessListView() .navigationBarHidden(true), isActive: $isRedirecting)
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoading: true)
    }
}


struct UserImage: View {
    var body: some View {
        Image("c-milk-tea")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct WelcomeText: View {
    var body: some View {
        Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct ButtonContent: View {
    var text: String
    var body: some View {
        Text(text)
            .bold()
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}
