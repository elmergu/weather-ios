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
    private var _currentDay: String!
    private var _currentTempText: String!
    private var _currentTempImage: String!
    private var _currentTempMinMax: String!
    private var _currentHumidity: String!
    private var _currentWindSpeed: String!
    private var _secondDayTempMinMax: String!
    private var _secondDay: String!
    private var _secondDayTempImage: String!
    private var _thirdDayTempMinMax: String!
    private var _thirdDayTempImage: String!
    private var _thirdDay: String!
    
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
    
    var currentDay: String {
        if _currentDay == nil {
            _currentDay = ""
        }
        
        return _currentDay
    }
        
        
    var secondDayTempMinMax: String {
        if _secondDayTempMinMax == nil {
            _secondDayTempMinMax = ""
        }
        
        return _secondDayTempMinMax
    }
    
    var secondDay: String {
        if _secondDay == nil {
            _secondDay = ""
        }
        
        return _secondDay
    }
    
    var secondDayTempImage: String {
        if _secondDayTempImage == nil {
            _secondDayTempImage = ""
        }
        
        return _secondDayTempImage
    }
    
    var thirdDayTempMinMax: String {
        if _thirdDayTempMinMax == nil {
            _thirdDayTempMinMax = ""
        }
        
        return _thirdDayTempMinMax
    }
    
    var thirdDay: String {
        if _thirdDay == nil {
            _thirdDay = ""
        }
        
        return _thirdDay
    }
    
    var thirdDayTempImage: String {
        if _thirdDayTempImage == nil {
            _thirdDayTempImage = ""
        }
        
        return _thirdDayTempImage
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
                    
//                    let minTemp = current["temp_min"] as? Float
//                    let maxTemp = current["temp_max"] as? Float
//                    
//                    let strMin = String(format: "%.0f°", self.convertKelvinToFahrenheit(minTemp!))
//                    let strMax = String(format: "%.0f°", self.convertKelvinToFahrenheit(maxTemp!))
//                    
//                    self._currentTempMinMax = "\(strMin)/\(strMax)"
                    self._currentHumidity = "\(current["humidity"]!)%"
                }
                
                let currentDayDay = JSON["dt"]! as? AnyObject
                self._currentDay = "\(currentDayDay!)"
                
                if let wind = JSON["wind"] as? Dictionary<String, AnyObject> {
                    let speed = self.convertMetersPerSecondToMilesPerHour((wind["speed"] as? Float)!)
                    self._currentWindSpeed = "\(String(format: "%.0f", speed))Mph"
                }
                
                if let weather = JSON["weather"] as? [Dictionary<String, AnyObject>] {
                    self._currentTempText = "\(weather[0]["main"]!)"
                    let iconName = weather[0]["icon"] as? String
                    self._currentTempImage = "\(iconName!)"
                }
                
                
                
                let nsUrl = "\(URL_BASE)\(URL_FORECAST)?q=\(escapedLocation)&APPID=\(APPID)&count=3"
                Alamofire.request(.GET, nsUrl).responseJSON { response in
                    if let forecastDict = response.result.value {
                        if let forecast = forecastDict["list"] where forecast!.count > 0 {

                            if let forecastByDay = forecast as? [Dictionary<String, AnyObject>] {
                                var minTemp = forecastByDay[0]["temp"]!["min"] as? Float
                                var maxTemp = forecastByDay[0]["temp"]!["max"] as? Float

                                var strMin = String(format: "%.0f°", self.convertKelvinToFahrenheit(minTemp!))
                                var strMax = String(format: "%.0f°", self.convertKelvinToFahrenheit(maxTemp!))
                                

                                self._currentTempMinMax = "\(strMin)/\(strMax)"

                                minTemp = forecastByDay[1]["temp"]!["min"] as? Float
                                maxTemp = forecastByDay[1]["temp"]!["max"] as? Float

                                
                                
                                if let forecastSecond = forecastByDay[1]["weather"] where forecastSecond.count > 0 {
                                    if let forecastSecondDay = forecastSecond as? [Dictionary<String, AnyObject>] {
                                        let secondDayImageTemp = forecastSecondDay[0]["icon"]! as? String
                                        self._secondDayTempImage = "b\(secondDayImageTemp!)"
                                    }
                                }
                                
                                strMin = String(format: "%.0f°", self.convertKelvinToFahrenheit(minTemp!))
                                strMax = String(format: "%.0f°", self.convertKelvinToFahrenheit(maxTemp!))

                                self._secondDayTempMinMax = "\(strMin)/\(strMax)"
                                self._secondDay = "\(forecastByDay[1]["dt"]!)"
                                
                                
                                if let forecastThird = forecastByDay[2]["weather"] where forecastThird.count > 0 {
                                    if let forecastThirdDay = forecastThird as? [Dictionary<String, AnyObject>] {
                                        let thirdDayImageTemp = forecastThirdDay[0]["icon"]! as? String
                                        self._thirdDayTempImage = "b\(thirdDayImageTemp!)"
                                    }
                                }
                                
                                minTemp = forecastByDay[2]["temp"]!["min"] as? Float
                                maxTemp = forecastByDay[2]["temp"]!["max"] as? Float
                                strMin = String(format: "%.0f°", self.convertKelvinToFahrenheit(minTemp!))
                                strMax = String(format: "%.0f°", self.convertKelvinToFahrenheit(maxTemp!))
                                
                                self._thirdDayTempMinMax = "\(strMin)/\(strMax)"
                                self._thirdDay = "\(forecastByDay[2]["dt"]!)"
                                
                            }

                        }
                    }
                    
                    completed()
                }
                
            }
            
            
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