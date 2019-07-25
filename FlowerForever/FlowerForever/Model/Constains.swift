//
//  Constains.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation

class Const {
    static let shared = Const()
    private init() {}

    let cellIdentifier = "ImageCell"

    let defaultTitleHeight = 51
    let defaultButtonHeight = 51

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
