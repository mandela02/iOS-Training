//
//  ApiRouter.swift
//  NetworkLayerDemo
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    case getPosts(userId: Int, id: Int)
    
    func asURLRequest() throws -> URLRequest {
        let URL = try Constants.baseUrl.asURL()
        
        var UrlRequest = URLRequest(url: URL.appendingPathComponent(path))
        
        UrlRequest.httpMethod = method.rawValue
        
        UrlRequest.addValue(Constants.ContentType.json.rawValue,
                            forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        UrlRequest.addValue(Constants.ContentType.json.rawValue,
                            forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(UrlRequest, with: parameters)
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getPosts:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getPosts:
            return "posts"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .getPosts(let userId, let id):
            return [Constants.Parameters.userId : userId, Constants.Parameters.id: id]
        }
    }
}
