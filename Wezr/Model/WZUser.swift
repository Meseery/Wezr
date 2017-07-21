//
//  WZUser.swift
//  Wezr
//
//  Created by Mohamed EL Meseery on 7/18/17.
//  Copyright © 2017 Meseery. All rights reserved.
//

import Foundation

class User {
    var lastCityId: Int? {
        get {
            return UserDefaults.standard.value(forKey: "CityId") as? Int
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "CityId")
        }
    }
    
    var lastCityName: String? {
        get {
            return UserDefaults.standard.value(forKey: "CityName") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "CityName")
        }
    }
}
