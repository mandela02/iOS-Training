//
//  ViewModelForCell.swift
//  FlowerForeverMVVM
//
//  Created by mac on 8/9/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ViewModelForCell {
    let realm = RealmDatabase()
    var favoriteImagesList: BehaviorRelay<[Int]> = BehaviorRelay(value: [])
    var currentImageId: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var currentHit: BehaviorRelay<Hit> = BehaviorRelay(value: Hit())

    var disposeBag = DisposeBag()

    init() {
        initData()
    }

    func initData() {
        var list: [Int] = []
        realm.storagedImages?.forEach({ image in
            list.append(image.imageId)
        })
        favoriteImagesList.accept(list)
        print(favoriteImagesList.value)
    }
}

extension ViewModelForCell {
    var isInDatabase: Observable<Bool> {
        return currentImageId.asObservable().map({ [weak self] in
            self?.favoriteImagesList.value.contains($0) ?? false
        })
    }

    func saveImagetoDatabase() {
        realm.insertToDatabase(withImageId: currentImageId.value)
    }

    func deleteImageInDatabase() {
        realm.deleteFromDatabase(withImageId: currentImageId.value)
    }

    func likeButtonTapped() {
        print("tapped")
        isInDatabase.asObservable().subscribe(onNext: { [weak self] isInDatabase in
            isInDatabase ? self?.deleteImageInDatabase() : self?.saveImagetoDatabase()
            self?.initData()
        }).disposed(by: disposeBag)
    }
}
