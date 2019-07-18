//
//  BroadcastData.swift
//  WeatherWizard
//
//  Created by mac on 7/17/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.

import Foundation
import Alamofire

class ForecastData {
    var listOfForecastData: [Forecast] =  []
    func downloadForecastData(completed: @escaping () -> Void) {
        let broadcastUrl = URL(string: Url.forecastUrl)
        guard broadcastUrl != nil else {
            return
        }
        Alamofire.request(broadcastUrl!).responseJSON { (response) in
            if let dict = response.value as? [String: AnyObject] {
                if let list = dict["list"] as? [[String: AnyObject]] {
                    for obj in list {
                        let forecast = Forecast(forecast: obj)
                        self.listOfForecastData.append(forecast)
                    }
                }
            }
            completed()
        }
    }
}
