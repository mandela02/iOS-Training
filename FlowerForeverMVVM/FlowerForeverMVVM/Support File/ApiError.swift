//
//  ApiError.swift
//  NetworkLayerDemo
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}
