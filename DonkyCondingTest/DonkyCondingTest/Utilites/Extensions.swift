//
//  Extensions.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 27/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

protocol JSONDecodable {
    associatedtype SubType
    init?(jsonObject: Any)
    static func decodeArray(jsonObject: Any) -> Array<SubType>?
}

extension JSONDecodable {
    static func decodeArray(jsonObject: Any) -> Array<Self>? {
        guard let jsonArray = jsonObject as? Array<Any> else {
            return nil
        }
        
        var objects = Array<Self>()
        for obj in jsonArray {
            guard let element = Self(jsonObject: obj) else {
                return nil
            }
            
            objects.append(element)
        }
        
        return objects
    }
}
