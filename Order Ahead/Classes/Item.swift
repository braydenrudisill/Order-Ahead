//
//  Item.swift
//  Order Ahead
//
//  Created by BrownPenguin on 8/29/21.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var ingredients: String
    var itemArtString: String
    var price: Int
    
    

}
