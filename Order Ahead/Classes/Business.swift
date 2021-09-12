//
//  Business.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/7/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Business: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var menu: [ItemList]
}

#if DEBUG
let testData = (1...10).map { i in
    Business(name: "Restaurant \(i)", menu: typeList)
}
#endif
