//
//  Broadcast.swift
//  WeatherWizard
//
//  Created by mac on 7/17/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import Foundation
import Alamofire

class Broadcast {
    private var _date: String!
    private var _status: String!
    private var _maxTemp: String!
    private var _minTemp: String!
    
    var date: String {
        get {
            if _date == nil {
                _date = ""
            }
            return _date
        }
        set {
            _date = newValue
        }
    }
    
    var status: String {
        get {
            if _status == nil {
                _status = ""
            }
            return _status
        }
        set {
            _status = newValue
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
    
    init(broadcast: Dictionary<String, AnyObject>) {
        if let temp = broadcast["temp"] as? Dictionary <String, AnyObject> {
            if let max = temp["max"] as? Double {
                self.maxTemp = "\(round(max - 275.15))"
            }
            if let min = temp["min"] as? Double {
                self.minTemp = "\(round(min - 275.15))"
            }
        }
        if let weather = broadcast["weather"] as? [Dictionary <String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self.status = main.capitalized
            }
        }
        if let dt = broadcast["dt"] as? Double {
            let unixDate = Date(timeIntervalSince1970: dt)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "EEEE" //Specify your format that you want
            self.date = dateFormatter.string(from: unixDate)
        }
    }
}
