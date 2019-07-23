//
//  FlowerImageData.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import Alamofire

class FlowerImageData {
    static let sharedFlowerData = FlowerImageData()
    var listOfFlowers: [Flower] = []

    private init() {
    }

    func downloadFlowerDataFromInternet(completed: @escaping () -> Void) {
        guard let flowerUrl = URL(string: Url.yellowFlowersUrl) else {
                return
        }
        Alamofire.request(flowerUrl).responseJSON { (response) in
            if let dict = response.value as? [String: AnyObject] {
                if let hits = dict["hits"] as? [[String: AnyObject]] {
                    for flowerData in hits {
                        let flower = Flower(flowerData: flowerData)
                        self.listOfFlowers.append(flower)
                    }
                }
            }
            completed()
        }
    }
}
