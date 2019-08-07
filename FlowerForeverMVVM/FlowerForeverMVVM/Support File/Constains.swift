//
//  Constains.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let baseUrl = "https://pixabay.com/api/"
    static let apiKey = "13112092-54e8286568142add194090167"

    struct Parameters {
        static let key = "key"
        static let queue = "q"
        static let pages = "page"
    }
    
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
}
