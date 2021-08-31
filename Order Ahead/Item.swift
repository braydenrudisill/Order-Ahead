//
//  Item.swift
//  Order Ahead
//
//  Created by BrownPenguin on 8/29/21.
//

import Foundation

struct Item: Identifiable, Codable, Hashable {
    var id: Int
    var name: String
    var ingredients: String
    var itemArtString: String
    var price: Int
    
}

