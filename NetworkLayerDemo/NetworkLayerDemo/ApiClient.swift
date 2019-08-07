//
//  ApiClient.swift
//  NetworkLayerDemo
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class ApiClient {
    
    static func getPosts(userId: Int, id: Int) -> Observable<[Post]> {
        return request(ApiRouter.getPosts(userId: userId, id: id))
    }
    
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create({ observer in
            let request = Alamofire
                .request(urlConvertible)
                .responseData(completionHandler: { (response) in
                    print(response)
                    switch response.result {
                    case .success(_):
                        let model = try! JSONDecoder().decode(T.self, from: response.data!)
                        observer.onNext(model)
                        observer.onCompleted()
                    case .failure(let error):
                        switch response.response?.statusCode {
                        case 403:
                            observer.onError(ApiError.forbidden)
                        case 404:
                            observer.onError(ApiError.notFound)
                        case 409:
                            observer.onError(ApiError.conflict)
                        case 500:
                            observer.onError(ApiError.internalServerError)
                        default:
                            observer.onError(error)
                        }
                    }
                })
            return Disposables.create {
                request.cancel()
            }
        }).retry(3)
    }
    
}

struct JSON {
    static let encoder = JSONEncoder()
}
extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}


