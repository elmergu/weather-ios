//
//  Config.swift
//  weather
//
//  Created by Estuardo Morales on 11/8/15.
//  Copyright © 2015 Estuardo Morales. All rights reserved.
//

import Foundation

let APPID = "b27783fc8b3d085ea01fedbbfebfd879"
let URL_BASE = "http://api.openweathermap.org/data/2.5/"
let URL_WEATHER = "weather"
let URL_FORECAST = "forecast/daily"

public typealias DownloadComplete = () -> ()