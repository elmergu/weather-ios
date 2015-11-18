//
//  ViewController.swift
//  weather
//
//  Created by Estuardo Morales on 11/7/15.
//  Copyright © 2015 Estuardo Morales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblCurrentTempText: UILabel!
    @IBOutlet weak var imgCurrentTemp: UIImageView!
    @IBOutlet weak var lblCurrentTempMinMax: UILabel!
    @IBOutlet weak var lblCurrentHumidity: UILabel!
    @IBOutlet weak var lblCurrentWindSpeed: UILabel!

    @IBOutlet weak var lblSecondTempMinMax: UILabel!
    @IBOutlet weak var lblThirdTempMinMax: UILabel!

    @IBOutlet weak var imgSeconDayIcon: UIImageView!
    @IBOutlet weak var imgThirdDayIcon: UIImageView!
    @IBOutlet weak var lblSecondDayDay: UILabel!
    @IBOutlet weak var lblThirdDayDay: UILabel!
    
    var weather = Weather(id: "Guatemala")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm ccc, dd. MMMM"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone(name: NSTimeZone.localTimeZone().abbreviation!)
        lblDate.text = formatter.stringFromDate(date)
        
        weather.getWeather { () -> () in
            self.updateUI()
        }
    }

    func updateUI() {
        lblCity.text = weather.city
        lblCurrentTemp.text = String(format: "%.0f°", weather.currentTemp)
        lblCurrentTempMinMax.text = weather.currentTempMaxMin
        lblCurrentHumidity.text = weather.currentHumidity
        lblCurrentWindSpeed.text = weather.currentWindSpeed
        lblCurrentTempText.text = weather.currentTempText
        
        let currentTimeinterval: NSTimeInterval = (weather.currentDay as NSString).doubleValue // convert it in to NSTimeInteral
        let currentDate = NSDate(timeIntervalSince1970:currentTimeinterval) // you can the Date object from here
        var formatter = NSDateFormatter()
        formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm ccc, dd. MMMM"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone(name: NSTimeZone.localTimeZone().abbreviation!)
        lblDate.text = formatter.stringFromDate(currentDate).uppercaseString

        
        lblSecondTempMinMax.text = weather.secondDayTempMinMax
        print(weather.currentDay)
        lblThirdTempMinMax.text = weather.thirdDayTempMinMax

        let imgSecondDay = UIImage(named: "\(weather.secondDayTempImage)")
        imgSeconDayIcon.image = imgSecondDay

        let imgThirdDay = UIImage(named: "\(weather.thirdDayTempImage)")
        imgThirdDayIcon.image = imgThirdDay

        let timeinterval : NSTimeInterval = (weather.secondDay as NSString).doubleValue // convert it in to NSTimeInteral
        let date = NSDate(timeIntervalSince1970:timeinterval) // you can the Date object from here

        
        formatter.dateFormat = "ccc"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone(name: NSTimeZone.localTimeZone().abbreviation!)
        lblSecondDayDay.text = formatter.stringFromDate(date).uppercaseString


        let timeintervalThird : NSTimeInterval = (weather.thirdDay as NSString).doubleValue // convert it in to NSTimeInteral
        let dateThird = NSDate(timeIntervalSince1970:timeintervalThird) // you can the Date object from here
        formatter = NSDateFormatter()
        formatter.dateFormat = "ccc"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone(name: NSTimeZone.localTimeZone().abbreviation!)
        lblThirdDayDay.text = formatter.stringFromDate(dateThird).uppercaseString
        

        let img = UIImage(named: "\(weather.currentTempImage)")
        imgCurrentTemp.image = img

    }

}

