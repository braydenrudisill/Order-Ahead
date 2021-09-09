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
  var question: String
  var answer: String
  var successful: Bool = true
  var userId: String?
}

#if DEBUG
let testData = (1...10).map { i in
  Business(question: "Question #\(i)", answer: "Answer #\(i)")
}
#endif
