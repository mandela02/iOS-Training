//
//  Constains.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation

enum Const {
    static let cellIdentifier = "ImageCell"
    static let baseUrl = "https://pixabay.com/api/"
    static let apiId = "?key="
    static var apiKey = "13112092-54e8286568142add194090167"
    static let queueId = "&q="
    static var queueKey = "yellow+flowers"
    static let imageTypeId = "&image_type="
    static var imageTypekey = "photo"
}

enum Url {
    static let yellowFlowersUrl = """
    \(Const.baseUrl)\
    \(Const.apiId)\
    \(Const.apiKey)\
    \(Const.queueId)\
    \(Const.queueKey)\
    \(Const.imageTypeId)\
    \(Const.imageTypekey)
    """
}
