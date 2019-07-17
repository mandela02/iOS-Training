//
//  Broadcast.swift
//  WeatherWizard
//
//  Created by mac on 7/17/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import Foundation
import Alamofire

class Forecast {
    private var _dayOfWeek: String!, _weatherStatus: String!, _maxTemp: String!, _minTemp: String!
    
    var date: String {
        get {
            if _dayOfWeek == nil {
                _dayOfWeek = ""
            }
            return _dayOfWeek
        }
        set {
            _dayOfWeek = newValue
        }
    }
    
    var status: String {
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
    
    var maxTemp: String {
        get {
            if _maxTemp == nil {
                _maxTemp = ""
            }
            return _maxTemp
        }
        set {
            _maxTemp = newValue
        }
    }
    
    var minTemp: String {
        get {
            if _minTemp == nil {
                _minTemp = ""
            }
            return _minTemp
        }
        set {
            _minTemp = newValue
        }
    }
    
    init(forecast: Dictionary<String, AnyObject>) {
        if let temp = forecast["temp"] as? [String: AnyObject] {
            if let max = temp["max"] as? Double {
                self.maxTemp = "\(round(max - 275.15))"
            }
            if let min = temp["min"] as? Double {
                self.minTemp = "\(round(min - 275.15))"
            }
        }
        if let weather = forecast["weather"] as? [[String: AnyObject]] {
            if let main = weather[0]["main"] as? String {
                self.status = main.capitalized
            }
        }
        if let dt = forecast["dt"] as? Double {
            let unixDate = Date(timeIntervalSince1970: dt)
            let dateFormatter = DateFormatter()
            //date format for day of week
            dateFormatter.dateFormat = "EEEE"
            self.date = dateFormatter.string(from: unixDate)
        }
    }
}
