//
//  WZForecastService.swift
//  Wezr
//
//  Created by Mohamed EL Meseery on 7/17/17.
//  Copyright © 2017 Meseery. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ForecastService {
    
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

class ForecastResource {
    
    var _lat : Double!
    var _lon : Double!
    
    var lon : Double {
        if _lon == nil {
            _lon = 0
        }
        return _lon
    }
    var lat : Double {
        if _lat == nil {
            _lat = 0
        }
        return _lat
    }
    
    var weatherURL : String {
        return "\(BASE_URL)\(LATITUDE)\(lat)\(LONGITUDE)\(lon)\(APP_ID)"
    }
    
    var forecastURL : String {
        return "\(FORECAST_URL)\(LATITUDE)\(lat)\(LONGITUDE)\(lon)\(FORECAST_APP_ID)"
    }
    
    init(lat:Double,lon:Double) {
        self._lon = lon
        self._lat = lat
    }
    
}
