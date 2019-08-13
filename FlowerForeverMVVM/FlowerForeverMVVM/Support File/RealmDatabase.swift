//
//  RealmDatabase.swift
//  FlowerForeverMVVM
//
//  Created by mac on 8/9/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class RealmDatabase {
    var realm = try? Realm()

    var storagedImages: Results<StoragedImage>? {
        return realm?.objects(StoragedImage.self)
    }

    var disposeBag = DisposeBag()

    init() {
        initData()
    }

    var favoriteImagesList: BehaviorRelay<[Int]> = BehaviorRelay(value: [])

    func initData() {
        var list: [Int] = []
        storagedImages?.forEach({ image in
            list.append(image.imageId)
        })
        favoriteImagesList.accept(list)
        print(favoriteImagesList.value)
    }

    func isInDatabase(forImageId imageId: Int) -> Bool {
        var isIndatabase = false
        storagedImages?.forEach { (storagedImage) in
            if storagedImage.imageId == imageId {
                isIndatabase = true
            }
        }
        return isIndatabase
    }

    func insertToDatabase(withImageId imageId: Int) {
        let storedImage = StoragedImage()
        storedImage.imageId = imageId
        do {
            try realm?.write {
                realm?.add(storedImage)
                print("insert")
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        favoriteImagesList.accept(favoriteImagesList.value + [imageId])
    }

    func deleteFromDatabase(withImageId imageId: Int) {
        let storagedImage = StoragedImage()
        storagedImage.imageId = imageId
        storagedImages?.forEach({ storagedImage in
            if storagedImage.imageId == imageId {
                do {
                    try realm?.write {
                        realm?.delete(storagedImage)
                        print("delete")
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        let index = favoriteImagesList.value.index(of: imageId)
        var tempArray = favoriteImagesList.value
        tempArray.remove(at: index!)
        favoriteImagesList.accept(tempArray)
    }

    func deleteAllDatabase() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
