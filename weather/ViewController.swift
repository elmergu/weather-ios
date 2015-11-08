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
    
    
    var weather = Weather(id: "Guatemala,Guatemala")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weather.getWeather { () -> () in
            self.updateUI()
        }
    }
    
    func updateUI() {
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm a / cccc, dd. MMMM"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone(name: NSTimeZone.localTimeZone().abbreviation!)
        lblDate.text = formatter.stringFromDate(date)
        
        lblCity.text = weather.city
        lblCurrentTemp.text = String(format: "%.0f°", weather.currentTemp)
        lblCurrentTempMinMax.text = weather.currentTempMaxMin
        lblCurrentHumidity.text = weather.currentHumidity
        lblCurrentWindSpeed.text = weather.currentWindSpeed
        lblCurrentTempText.text = weather.currentTempText
        
        let img = UIImage(named: "\(weather.currentTempImage)")
        imgCurrentTemp.image = img

    }

}

