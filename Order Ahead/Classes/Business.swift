//
//  Business.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/7/21.
//

import Foundation
import FirebaseFirestoreSwift

class Business: Identifiable, Codable, ObservableObject {
    @DocumentID var id: String?
    var docID: String?
    var uid: String
    var stripeaccountid: String
    var name: String
    var menu: [ItemList]
    
    init(uid: String, name: String, menu: [ItemList]) {
        self.uid = uid
        self.name = name
        self.menu = menu
        self.stripeaccountid = ""
    }
    
    init() {
        self.uid = ""
        self.name = ""
        self.menu = []
        self.stripeaccountid = ""
    }
}

#if DEBUG
//let testData = (1...10).map { i in
//    Business(uid: "\(i)", stripeaccountid: "acct_1JWx8o2fMFAGPH", name: "Restaurant \(i)", menu: typeList)
//}
#endif
