//
//  StoreView.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 8/29/21.
//

import SwiftUI

struct StoreView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var business: Business
    @EnvironmentObject var cart: OrderModel
    @State var toCart = false;
    var backgroundColor: Color = Color("titleBackgroundColor")
    var body: some View {
        // Navigation view lets us use the buttons (milk, coffee, etc.)
        // and then go back, but we already have one surrounding this whole
        // thing in ContentView.swift so no need to add (that's how we got here)
        
        // Custom vertical scrolling tab view (from VTabView.swift)
        VTabView {
            // Creates a stack (where bottom gets covered) from bot to top
            // - background image
            // - diagonal background shape
            // - white line
            // - Ding Tea text
            // - Circle
            ZStack {
                // back button
                
                // Just something we wrap to access screen size (to fill background)
                GeometryReader { screen in
                    Image("c-milk-tea")
                        
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
                        .ignoresSafeArea(.all)

                }
                
                TitleShape()
                    .fill(backgroundColor)
                TitleLine(size: 5)
                    .fill(Color.white)
                
                // Something i made in TopLeft.swift to allign smth topleft
                TopLeft(){
                    Button("Back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
                }
                Text(business.name)
                    .offset(x: 69, y: 50)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
                
                // Should add a profile pic here, rn just a circle haha
                Circle()
                    .offset(x: -70, y:45)
                    .frame(height: 100)
                    
            }
            
            // Throwing a (category list with a background color) below so we can swipe down to it
            
            ZStack(){
                ZStack(alignment: .bottomTrailing) {
                    backgroundColor
                        .ignoresSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    NavigationLink(destination: CartView(business:business)) {
                        ZStack{
                            Circle()
                            .fill(Color( red: 54/255, green: 60/255, blue: 50/255, opacity: 1))
                            .frame(width: 80, height: 80)
                            Image("coffee")
                            .resizable()
                                .colorInvert()
                            .frame(width: 70, height: 70)
                        }
                        .padding()
                    }
                }
                TypeListView()
            }
        }
        .onAppear(perform: {
            UIScrollView.appearance().bounces = false
            cart.businessId = business.uid
            print(cart)
         })
        // ._. you need this and the other one in loginview.swift, idek why
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}

struct TitleShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height
            path.addLines( [
                CGPoint(x: width * 0, y: height),
                CGPoint(x: width * 0, y: height * 0.6),
                CGPoint(x: width * 1, y: height * 0.48),
                CGPoint(x: width * 1, y: height * 1)
            ])
            path.closeSubpath()
        }
    }
}
struct TitleLine: Shape {
    var size: CGFloat
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height
            path.addLines( [
                CGPoint(x: width * 0, y: height * 0.6),
                CGPoint(x: width * 1, y: height * 0.48),
                CGPoint(x: width * 1, y: height * 0.48 + size),
                CGPoint(x: width * 0, y: height * 0.6 + size),
            ])
            path.closeSubpath()
        }
    }
}
