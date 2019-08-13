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

    var currentHit: BehaviorRelay<Hit> = BehaviorRelay(value: Hit())

    var disposeBag = DisposeBag()

    init(withCurrentHit currentHit: BehaviorRelay<Hit>) {
        self.currentHit = currentHit
    }
}

extension ViewModelForCell {
    var isInDatabase: Observable<Bool> {
        return currentHit.asObservable().map({
            self.realm.favoriteImagesList.value.contains($0.id)
        })
    }

    func saveImagetoDatabase() {
        realm.insertToDatabase(withImageId: currentHit.value.id)
        realm.initData()
    }

    func deleteImageInDatabase() {
        realm.deleteFromDatabase(withImageId: currentHit.value.id)
        realm.initData()
    }

    func likeButtonTapped() {
        print("tapped")
        isInDatabase.asObservable().subscribe(onNext: { [weak self] isInDatabase in
            isInDatabase ? self?.deleteImageInDatabase() : self?.saveImagetoDatabase()
        }).disposed(by: disposeBag)
    }
}
