//
//  File.swift
//  WeatherWizard
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import Foundation

enum UrlElement {
    static let baseUrlCurrentWeather = "https://samples.openweathermap.org/data/2.5/weather?"
    static let baseUrlForecast = "https://samples.openweathermap.org/data/2.5/forecast/daily?"
    static let lat = "lat=12"
    static let lon = "&lon=21"
    static let apiId = "&appid="
    static let apiKey = "b6907d289e10d714a6e88b30761fae22"
    static let numberOfDay = "&cnt=10"
}
enum Url {
    static let currentWeatherUrl = """
    \(UrlElement.baseUrlCurrentWeather)\
    \(UrlElement.lat)\
    \(UrlElement.lon)\
    \(UrlElement.apiId)\
    \(UrlElement.apiKey)
    """
    static let forecastUrl = """
    \(UrlElement.baseUrlForecast)\
    \(UrlElement.lat)\
    \(UrlElement.lon)\
    \(UrlElement.numberOfDay)\
    \(UrlElement.apiId)\
    \(UrlElement.apiKey)
    """
}
