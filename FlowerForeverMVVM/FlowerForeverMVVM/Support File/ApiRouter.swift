//
//  ApiRouter.swift
//  FlowerForeverMVVM
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum ApiRouter: URLRequestConvertible {
    case getImages(apiKey: String, queue: String, page: Int)

    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(Constants.ContentType.json.rawValue,
                            forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        urlRequest.addValue(Constants.ContentType.json.rawValue,
                            forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)

        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()

        return try encoding.encode(urlRequest, with: parameters)
    }

    private var method: HTTPMethod {
        switch self {
        case .getImages:
            return .get
        }
    }

    private var parameters: Parameters? {
        switch self {
        case .getImages(let apiKey, let queue, let page):
            return [Constants.Parameters.key: apiKey,
                    Constants.Parameters.queue: queue,
                    Constants.Parameters.pages: page ]
        }
    }
}
