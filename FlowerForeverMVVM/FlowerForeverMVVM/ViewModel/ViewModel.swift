//
//  ViewModel.swift
//  FlowerForeverMVVM
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    static let shared = ViewModel()
    private let imageApi = ImageApi()
    private init() {}

    private let disposeBag = DisposeBag()

    func requireDataFromServer(withQuery query: String) -> BehaviorRelay<[Hit]> {
        let images: BehaviorRelay<[Hit]> = BehaviorRelay(value: [])
        guard query != "" else {
            return images
        }
        imageApi.getImagesData(apiKey: Constants.apiKey, queue: query, page: 1)
            .observeOn(MainScheduler.instance)
            .asObservable()
            .subscribe(onNext: { imageData in
                images.accept(imageData.hits)
            }, onError: { error in
                switch error {
                case ApiError.conflict:
                    print("Conflict error")
                case ApiError.forbidden:
                    print("Forbidden error")
                case ApiError.notFound:
                    print("Not found error")
                default:
                    print("Unknown error:", error)
                }
            }).disposed(by: disposeBag)
    return images
    }
}
