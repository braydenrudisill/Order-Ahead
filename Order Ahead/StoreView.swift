//
//  StoreView.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 8/29/21.
//

import SwiftUI

struct StoreView: View {
    var backgroundColor: Color = Color("titleBackgroundColor")
    var body: some View {
        // Navigation view lets us use the buttons (milk, coffee, etc.)
        // and then go back
        NavigationView {
            // Custom vertical scrolling tab view (from VTabView.swift)
            VTabView {
                // Creates a stack (where bot gets covered) from bot to top
                // - background image
                // - diagonal background shape
                // - white line
                // - Ding Tea text
                // - Circle
                ZStack {
                    // Just something we wrap to access screen size
                    GeometryReader { screen in
                        Image("c-milk-tea")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: screen.size.width , height: screen.size.height)
                    }
                    TitleShape()
                        .fill(backgroundColor)
                    TitleLine(size: 5)
                        .fill(Color.white)
                    Text("Ding Tea")
                        .offset(x: 69, y: 50)
                        .font(.system(size: 30))
                        .foregroundColor(Color.white)
                    Circle()
                        .offset(x: -70, y:45)
                        .frame(height: 100)
                        
                }
                ZStack{
                    backgroundColor
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    TypeListView()
                }
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}


struct TitleShape: Shape {
    // 1.
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height
            
            // 2.
            path.addLines( [
                CGPoint(x: width * 0, y: height),
                CGPoint(x: width * 0, y: height * 0.6),
                CGPoint(x: width * 1, y: height * 0.48),
                CGPoint(x: width * 1, y: height * 1)
            ])
            // 3.
            path.closeSubpath()
        }
    }
}
struct TitleLine: Shape {
    // 1.
    var size: CGFloat
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height
            
            // 2.
            path.addLines( [
                CGPoint(x: width * 0, y: height * 0.6),
                CGPoint(x: width * 1, y: height * 0.48),
                CGPoint(x: width * 1, y: height * 0.48 + size),
                CGPoint(x: width * 0, y: height * 0.6 + size),
            ])
            // 3.
            path.closeSubpath()
        }
    }
}
