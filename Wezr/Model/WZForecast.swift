//
//  WZForecast.swift
//  Wezr
//
//  Created by Mohamed EL Meseery on 7/17/17.
//  Copyright © 2017 Meseery. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class Forecast {
    
    var _date : String!
    var _weatherType : String!
    var _highTemp : Double!
    var _lowTemp : Double!
    
    
    var date : String {
        if _date == nil {
            _date = ""
        }
        
        return _date
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp : Double {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        return _highTemp
    }
    
    var lowTemp : Double {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        return _lowTemp
    }
    
    init(_ low: Double, _ high: Double, _ type: String, _ date: String){
        self._date = date
        self._lowTemp = low
        self._highTemp = high
        self._weatherType = type
    }
}




