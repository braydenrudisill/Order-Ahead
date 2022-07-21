//
//  Item.swift
//  Order Ahead
//
//  Created by BrownPenguin on 8/29/21.
//

import Foundation

struct ItemModel: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var ingredients: String
    var itemArtString: String
    var price: Int
    
    init() {
        name=""
        ingredients=""
        itemArtString=""
        price = -1
    }
    
    init(name: String, ingredients: String, itemArtString: String, price: Int) {
        self.name = name
        self.ingredients = ingredients
        self.itemArtString = itemArtString
        self.price = price
    }
}
