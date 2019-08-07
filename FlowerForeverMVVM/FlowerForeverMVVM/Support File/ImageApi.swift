//
//  ImageApi.swift
//  FlowerForeverMVVM
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class ImageApi {
    func getImagesData(apiKey: String, queue: String, page: Int) -> Observable<ImageData> {
        return request(ApiRouter.getImages(apiKey: apiKey, queue: queue, page: page))
    }

    private func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create({ observer in
            let request = Alamofire
                .request(urlConvertible)
                .responseData(completionHandler: { (response) in
                    switch response.result {
                    case .success(_):
                        guard let model = try? JSONDecoder().decode(T.self, from: response.data!) else {
                            fatalError()
                        }
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
