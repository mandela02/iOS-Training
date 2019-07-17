//
//  CurrentWeather.swift
//  WeatherWizard
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CurrentWeather {
    //wrong
    // fix dis tomorrow
    private var _temperature: String!, _location: String!, _currentDate: String!, _weatherStatus: String!
    
    var temperature: String {
        get {
            if _temperature == nil {
                _temperature = ""
            }
            return _temperature
        }
        set {
            _temperature = newValue
        }
    }
    
    var location: String {
        get {
            if _location == nil {
                _location = ""
            }
            return _location
        }
        set {
            _location = newValue
        }
    }
    
    var currentDate: String {
        get {
            if _currentDate == nil {
                _currentDate = ""
            }
            let date = DateFormatter.localizedString(from: Date(), dateStyle: .full, timeStyle: .none)
            _currentDate = date
             return _currentDate
        }
        set {
            _currentDate = newValue
        }
    }
    
    var weatherStatus: String {
        get {
            if _weatherStatus == nil {
                _weatherStatus = ""
            }
            return _weatherStatus
        }
        set {
            _weatherStatus = newValue
        }
    }
    
    func downloadWeatherData(completed: @escaping () -> ()) {
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        Alamofire.request(currentWeatherURL!).responseJSON { response in
            if let dict = response.value as? [String: AnyObject] {
                if let name = dict["name"] as? String {
                    self.location = name.capitalized
                    print(self.location)
                }
                if let weather = dict["weather"] as? [[String: AnyObject]] {
                    if let main = weather[0]["main"] as? String {
                        self.weatherStatus = main.capitalized
                        print(self.weatherStatus)
                    }
                }
                if let main = dict["main"] as? [String: AnyObject]{
                    if let temp = main["temp"] as? Double {
                        let kelvinToCelsius = temp - 275.15
                            self.temperature = "\(round(kelvinToCelsius))"
                        print(self.temperature)
                    }
                }
            }
        completed()
        }
    }
}






