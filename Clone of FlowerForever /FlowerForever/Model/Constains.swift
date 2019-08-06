//
//  Constains.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import UIKit

class Const {
    static let shared = Const()
    private init() {}

    let sectionInsets = UIEdgeInsets(top: 1.0,
                                     left: 1.0,
                                     bottom: 1.0,
                                     right: 1.0)

    let cellIdentifier = "ImageCell"
    let numberOfCellinRow: CGFloat = 3

    let baseUrl = "https://pixabay.com/api/"
    let apiId = "?key="
    let apiKey = "13112092-54e8286568142add194090167"
    let queueId = "&q="
    let imageTypeId = "&image_type="
    let pages = "&page="

    var queueKey = "girl"
    var imageTypekey = "photo"
    var page = 1

    var imageURL: String {
        let url = """
        \(baseUrl)\
        \(apiId)\
        \(apiKey)\
        \(queueId)\
        \(queueKey)\
        \(pages)\
        \(page)
        """
        return url
    }
}
