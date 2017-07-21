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

class Weather {
    
    var _cityName : String!
    var _date : String!
    var _weatherType : String!
    var _currentTemp : Double!
    
    var cityName : String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date : String {
        if _date == nil {
            _date = ""
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let currentDate = formatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp : Int {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return Int(_currentTemp.rounded())
    }
    
    func downloadWeather(completed: @escaping DownloadComplete){
        
        let apiCall = ForecastResource(lat: Location.sharedInstance.latitude, lon: Location.sharedInstance.longitude)
        let weatherURL = URL(string: apiCall.weatherURL)
        Alamofire.request(weatherURL!).responseJSON { response in
            
            if let data = response.data {
                let json = JSON(data: data)
                
                self._cityName = json["name"].string!.capitalized
                self._weatherType = json["weather"][0]["main"].string!.capitalized
                self._currentTemp = json["main"]["temp"].double!.KtoF()
            }
            
            }.response { _ in completed() }
    }
}

/*
 struct Forecast {
    let forecastTime: Date
    let temperature: Measurement<UnitTemperature>
    let pressure: Measurement<UnitPressure>
    let weatherDescription: String
}
 */

