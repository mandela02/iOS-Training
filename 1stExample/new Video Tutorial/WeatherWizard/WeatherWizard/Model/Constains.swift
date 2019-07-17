//
//  File.swift
//  WeatherWizard
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import Foundation

let BASE_URL_CURRENT_WEATHER = "https://samples.openweathermap.org/data/2.5/weather?"
let BASE_URL_BROADCAST = "https://samples.openweathermap.org/data/2.5/forecast/daily?"
let LATTITUDE = "lat=12"
let LONGTITUDE = "&lon=21"
let API_ID = "&appid="
let API_KEY = "b6907d289e10d714a6e88b30761fae22"

let NUM_OF_DAY = "&cnt=10"

typealias DownloadComplete = () -> ()
//() -> () just means Void -> Void - a closure that accepts no parameters and has no return value.
    
let CURRENT_WEATHER_URL = "\(BASE_URL_CURRENT_WEATHER)\(LATTITUDE)\(LONGTITUDE)\(API_ID)\(API_KEY)"

let BROADCAST_URL = "\(BASE_URL_BROADCAST)\(LATTITUDE)\(LONGTITUDE)\(NUM_OF_DAY)\(API_ID)\(API_KEY)"
