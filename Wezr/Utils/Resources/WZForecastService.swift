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


/*

class ForecastService {
    // Get weather data from OpenWeatherMap.org for the given location
    func getForecast(forCityID Id: Int, withHandler completion: @escaping (JSON) -> () ) {
        let apiUrl = "\(API.API_BASE_URL)forecast?id=\(Id)&units=metric&appid=\(API.API_KEY)"
        
        Alamofire.request(apiUrl).responseJSON { (response) in
            let json = JSON(response.result.value as Any)
            completion(json)
        }
    }
    
    // Parse weather data received from OpenWeatherMap.org to a usable array of Forecast objects
    func parseForecasts(jsonData: JSON) -> [Forecast] {
        var forecasts = [Forecast]()
        for (_, subJson) in jsonData["list"] {
            let forecast = Forecast(forecastTime: Date(timeIntervalSince1970: TimeInterval(subJson["dt"].intValue)),
                                    temperature: Measurement.init(value: subJson["main"]["temp"].doubleValue, unit: UnitTemperature.celsius),
                                    pressure: Measurement.init(value: subJson["main"]["pressure"].doubleValue, unit: UnitPressure.bars),
                                    weatherDescription: subJson["weather"][0]["description"].stringValue)
            forecasts.append(forecast)
        }
        return forecasts
    }

}
 */
