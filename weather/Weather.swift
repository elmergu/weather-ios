//
//  Weather.swift
//  weather
//
//  Created by Estuardo Morales on 11/8/15.
//  Copyright © 2015 Estuardo Morales. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    private var _id: String!
    private var _city: String!
    private var _currentTemp: Float!
    private var _currentTempText: String!
    private var _currentTempImage: String!
    private var _currentTempMinMax: String!
    private var _currentHumidity: String!
    private var _currentWindSpeed: String!
    
    var city: String {
        if _city == nil {
            _city = ""
        }
        return _city
    }
    
    var currentTemp: Float {
        if _currentTemp == nil {
            _currentTemp = 0
        }
        return _currentTemp
    }
    
    var currentTempText: String {
        if _currentTempText == nil {
            _currentTempText = ""
        }
        return _currentTempText
    }
    
    var currentTempImage: String {
        if _currentTempImage == nil {
            _currentTempImage = ""
        }
        return _currentTempImage
    }
    
    var currentTempMaxMin: String {
        if _currentTempMinMax == nil {
            _currentTempMinMax = ""
        }
        return _currentTempMinMax
    }
    
    var currentHumidity: String {
        if _currentHumidity == nil {
            _currentHumidity = ""
        }
        return _currentHumidity
    }
    
    var currentWindSpeed: String {
        if _currentWindSpeed == nil {
            _currentWindSpeed = ""
        }
        return _currentWindSpeed
    }
    
    init(id: String) {
        _id = id
    }
    
    func getWeather (completed: DownloadComplete) {
        let escapedLocation = _id.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        let url = "\(URL_BASE)\(URL_WEATHER)?q=\(escapedLocation)&APPID=\(APPID)"

        Alamofire.request(.GET, url).responseJSON { response in
            
            if let JSON = response.result.value as? Dictionary<String, AnyObject>  {
                
                if let city = JSON["name"] as? String {
                    self._city = city
                }
                
                if let current = JSON["main"] as? Dictionary<String, AnyObject> {
                    let kelvin = current["temp"] as? Float
                    self._currentTemp = round(self.convertKelvinToFahrenheit(kelvin!))
                    
                    let minTemp = current["temp_min"] as? Float
                    let maxTemp = current["temp_max"] as? Float
                    
                    let strMin = String(format: "%.0f°", self.convertKelvinToFahrenheit(minTemp!))
                    let strMax = String(format: "%.0f°", self.convertKelvinToFahrenheit(maxTemp!))
                    
                    self._currentTempMinMax = "\(strMin)/\(strMax)"
                    self._currentHumidity = "\(current["humidity"]!)%"
                }
                
                if let wind = JSON["wind"] as? Dictionary<String, AnyObject> {
                    let speed = self.convertMetersPerSecondToMilesPerHour((wind["speed"] as? Float)!)
                    self._currentWindSpeed = "\(String(format: "%.0f°", speed))Mph"
                }
                
                if let weather = JSON["weather"] as? [Dictionary<String, AnyObject>] {
                    self._currentTempText = "\(weather[0]["main"]!)"
                    let iconName = weather[0]["icon"] as? String
                    self._currentTempImage = "\(iconName!)"
                }
            }
            
            completed()
            
        }
        
    }
    
    func convertMetersPerSecondToMilesPerHour(speed: Float) -> Float {
        return speed / (1609.44/3600)
    }

    func convertKelvinToCelcius(kelvin: Float) -> Float {
        return 300 - kelvin
    }
    
    func convertKelvinToFahrenheit(kelvin: Float) -> Float {
        return kelvin * 9.0/5.0 - 459.67
    }
}