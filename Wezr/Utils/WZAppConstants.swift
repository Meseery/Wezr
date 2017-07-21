//
//  WZAppConstants.swift
//  Wezr
//
//  Created by Mohamed EL Meseery on 7/17/17.
//  Copyright © 2017 Meseery. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid=043ebd526920548a451d40b18a92d62b"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let FORECAST_APP_ID = "&cnt=10&appid=0356f0d8e9865300021b8b2ba08ee811"

typealias DownloadComplete = () -> ()
