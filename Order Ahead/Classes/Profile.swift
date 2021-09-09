//
//  Profile.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/2/21.
//

import Foundation

struct Profile {
    var email: String
    var stripe_customer_id: String

    static let `default` = Profile(email: "", stripe_customer_id: "")
    
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
          guard let label = label else { return nil }
          return (label, value)
        }).compactMap { $0 })
        return dict
      }
}

