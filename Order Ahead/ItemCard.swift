//
//  ContentView.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 8/29/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
        Text("test")
            .padding()
    }
}

struct ItemCard: View {
    var item: Item
    var body: some View {
        HStack {
            Image(item.itemArtString)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                    .lineLimit(2)
                Text(item.ingredients)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            Spacer()
        }
        .padding()
        .frame(height: 80)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .shadow(radius: 1)
    }
    
    
}

struct ItemCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ItemCard(item: milkList.list[0])
                .previewLayout(.fixed(width: 300, height: 510))
            ItemCard(item: milkList.list[1])
                .previewLayout(.fixed(width: 300, height: 510))
        }
    }
}
