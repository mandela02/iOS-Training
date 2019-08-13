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
import UIKit

class ViewModel {
    static let shared = ViewModel()
    private let imageApi = ImageApi()
    var realmDatabase = RealmDatabase()
    private init() {}

    private let disposeBag = DisposeBag()

    private var imagesList: [Hit] = []

    let images: BehaviorRelay<[Hit]> = BehaviorRelay(value: [])
    var currentPage: BehaviorRelay<Int> = BehaviorRelay(value: 1)
    var currentQuery: BehaviorRelay<String> = BehaviorRelay(value: "")
    var prefetchIndex: BehaviorRelay<IndexPath> = BehaviorRelay(value: IndexPath(item: 0, section: 0))
    var currentIndex: BehaviorRelay<IndexPath> = BehaviorRelay(value: IndexPath(item: 0, section: 0))
    let totalHits: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var currentHit: BehaviorRelay<Hit>!

    func clearMemory() {
        imagesList.removeAll()
        currentPage.accept(1)
        images.accept([])
        prefetchIndex.accept(IndexPath(item: 0, section: 0))
    }

    func downloadDataFromServer() {
        guard currentQuery.value != "" else {
            clearMemory()
            return
        }
        imageApi.getImagesData(apiKey: Constants.apiKey, queue: currentQuery.value, page: currentPage.value)
            .observeOn(MainScheduler.instance)
            .asObservable()
            .subscribe(onNext: { [weak self] imageData in
                self?.imagesList = (self?.imagesList)! + imageData.hits
                self?.images.accept((self?.imagesList)!)
                self?.totalHits.accept(imageData.totalHits)
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
        currentPage.accept(currentPage.value + 1)
    }

    var triggerFetchingMoreData: Observable<Bool> {
        return prefetchIndex
            .asObservable()
            .map({
                $0.item == self.imagesList.count - 1
                || $0.row == self.imagesList.count - 1
                && self.imagesList.count <= self.totalHits.value})
    }
}

extension ViewModel {
    func getFileName(fromUrl url: String) -> String {
        guard let filename = URL(string: url)?.lastPathComponent else {
            return ""
        }
        return filename
    }

    func saveToCache(_ image: UIImage, inLink url: String) {
        imageApi.saveImageToCache(image, filename: getFileName(fromUrl: url))
    }

    func getImageFromCache(inLink url: String) -> UIImage? {
        return imageApi.getImageFromCache(with: getFileName(fromUrl: url))
    }
}
