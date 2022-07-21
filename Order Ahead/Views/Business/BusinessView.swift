// Copyright (c) 2020 Razeware LLC

import SwiftUI

struct BusinessView: View {
    var businessViewModel: BusinessViewModel
    var cart: OrderModel = OrderModel()
    @State var showContent: Bool = false
    @State var viewState = CGSize.zero
    @State var showAlert = false
    @State var isRedirecting = false
    
    var body: some View {
        VStack(alignment: .center) {
            Text(businessViewModel.business.name)
            // pass business data here
            NavigationLink("",
                           destination: StoreView()
                            .environmentObject(businessViewModel.business)
                            .environmentObject(cart)
                            .navigationBarHidden(true),
                           isActive: $isRedirecting
            )
        }
        .frame(width: 250, height: 400)
        .background(Color.orange)
        .cornerRadius(20)
        .shadow(color: Color(.blue).opacity(0.3), radius: 5, x: 10, y: 10)

        .offset(x: viewState.width, y: viewState.height)
        .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
        .onTapGesture {
            isRedirecting = true
        }
        .gesture(
          DragGesture()
            .onChanged { value in
              viewState = value.translation
            }
          .onEnded { value in
            if value.location.y < value.startLocation.y - 40.0 {
              showAlert.toggle()
            }
            viewState = .zero
          }
        )
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Remove Business"),
                message: Text("Are you sure you want to remove this business?"),
                primaryButton: .destructive(Text("Remove")) {
                    businessViewModel.remove()
                },
                secondaryButton: .cancel())
        }
    }

    func update(business: Business) {
        businessViewModel.update(business: business)
        showContent.toggle()
    }
}

struct BusinessView_Previews: PreviewProvider {
  static var previews: some View {
    let business = Business()
    return BusinessView(businessViewModel: BusinessViewModel(business: business))
  }
}
