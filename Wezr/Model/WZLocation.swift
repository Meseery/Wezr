//
//  WZLocation.swift
//  Wezr
//
//  Created by Mohamed EL Meseery on 7/20/17.
//  Copyright © 2017 Meseery. All rights reserved.
//

import Foundation

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init () {  }
    var latitude : Double!
    var longitude : Double!
    
}
