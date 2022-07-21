//
//  OrderModel.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 12/18/21.
//

import SwiftUI
import FirebaseFirestoreSwift

class OrderModel: Codable,Identifiable,ObservableObject {
    
    @DocumentID var id: String?
    var items: [ItemModel]
    var name: String
    var timeStamp: Date
    var businessId: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case items
        case name
        case timeStamp
        case businessId
    }
    
    init() {
        items = []
        name = ""
        timeStamp = Date()
        businessId = ""
    }
    
    init(b:String) {
        items = []
        name = ""
        timeStamp = Date()
        businessId = b
    }
    
    init(i: [ItemModel], n:String, t:Date, b:String){
        items = i
        name = n
        timeStamp = t
        businessId = b
    }
    
    func remove(item: ItemModel) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}
