//
//  BroadcastData.swift
//  WeatherWizard
//
//  Created by mac on 7/17/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.

import Foundation
import Alamofire

class BroadcastData {
    var listOfBroadcast =  [Broadcast]()
    
    func downloadBroadcastData(completed: @escaping () -> ()) {
        let broadcastUrl = URL(string: BROADCAST_URL)
        Alamofire.request(broadcastUrl!).responseJSON { (response) in
            if let dict = response.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let broadcast = Broadcast(broadcast: obj)
                        self.listOfBroadcast.append(broadcast)
                        print(obj)
                    }
                }
            }
            completed()
        }
    }
}
