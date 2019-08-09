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
    var favoriteImage: BehaviorRelay<Int> = BehaviorRelay(value: 0)

    var disposeBag = DisposeBag()

    init() {
        initData()
    }

    func initData() {
        var list: [Int] = []
        realm.storagedImages?.forEach({ (image) in
            list.append(image.imageId)
        })
        favoriteImagesList.accept(list)
    }

    var isInDatabase: Observable<Bool> {
        return favoriteImage.asObservable().map({ [weak self] in
            self?.favoriteImagesList.value.contains($0) ?? false
        })
    }
}

extension ViewModelForCell {
    func saveImagetoDatabase() {
        realm.insertToDatabase(withImageId: favoriteImage.value)
    }

    func deleteImageInDatabase() {
        realm.deleteFromDatabase(withImageId: favoriteImage.value)
    }

    func likeButtonTapped() {
        isInDatabase.asObservable().subscribe(onNext: { [weak self] isInDatabase in
            isInDatabase ? self?.deleteImageInDatabase() : self?.saveImagetoDatabase()
            self?.initData()
        }).disposed(by: disposeBag)
    }
}
