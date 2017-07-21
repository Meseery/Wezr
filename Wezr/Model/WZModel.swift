//
//  WZModel.swift
//  Wezr
//
//  Created by Mohamed EL Meseery on 7/19/17.
//  Copyright © 2017 Meseery. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONable {
    init?(parameter: JSON)
}

extension JSON {
    func to<T>(type: T?) -> Any? {
        if let baseObj = type as? JSONable.Type {
            if self.type == .array {
                var arrObject: [Any] = []
                for obj in self.arrayValue {
                    let object = baseObj.init(parameter: obj)
                    arrObject.append(object!)
                }
                return arrObject
            } else {
                let object = baseObj.init(parameter: self)
                return object!
            }
        }
        return nil
    }
}
