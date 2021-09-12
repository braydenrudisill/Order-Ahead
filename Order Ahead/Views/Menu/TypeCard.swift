//
//  TypeCard.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 8/29/21.
//

import SwiftUI

struct TypeCard: View {
    
    var itemlist: ItemList
    @State private var clicked: Bool = false;
    
    var body: some View {
        
        NavigationLink(destination: ItemListView(itemlist: itemlist), isActive: $clicked) {
            Button(action: {self.clicked = true}) {
                ZStack {
                    VStack {
                        Image(itemlist.picture)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        Text(itemlist.name)
                            .font(.callout)
                            .lineLimit(2)
                            .accentColor(.black)
                    }
                    
                    .frame(width: 145, height: 145)
                    .background(Color.white)
                }
                
            }
            
        }
        
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .shadow(radius: 1)
        
    }
    
    
}

struct TypeCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TypeCard(itemlist: milkList)
                .previewLayout(.fixed(width: 300, height: 510))
            TypeCard(itemlist: teaList)
                .previewLayout(.fixed(width: 300, height: 510))
            TypeCard(itemlist: coffeeList)
                .previewLayout(.fixed(width: 300, height: 510))
            TypeCard(itemlist: fruitList)
                .previewLayout(.fixed(width: 300, height: 510))
        }
    }
}
