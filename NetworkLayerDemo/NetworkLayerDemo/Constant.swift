//
//  Constant.swift
//  NetworkLayerDemo
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation

struct Constants {
    static let baseUrl = "https://jsonplaceholder.typicode.com"
    
    struct Parameters {
        static let userId = "userId"
        static let id = "id"
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

