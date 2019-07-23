//
//  File.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import Alamofire

class Flower {
    private var _largeImageURL: String!

    var largeImageUrl: String {
        get {
            if _largeImageURL == nil {
                _largeImageURL = ""
            }
            return _largeImageURL
        }
        set {
            _largeImageURL = newValue
        }
    }

    init(flowerData: [String: AnyObject]) {
        if let largeImageURL = flowerData["largeImageURL"] as? String {
            self.largeImageUrl = largeImageURL
        }
    }
}
