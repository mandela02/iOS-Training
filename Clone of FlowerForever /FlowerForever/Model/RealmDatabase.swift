//
//  RealmDatabase.swift
//  FlowerForever
//
//  Created by mac on 8/2/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class RealmDatabase {
    var realm = try? Realm()

    var storagedImages: Results<StoragedImage>? {
        return realm?.objects(StoragedImage.self) ?? nil
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
//        do {
//            let realm1 = try Realm()
//        } catch {
//            print(NSError.init().localizedDescription)
//        }
        do {
            try realm?.write {
                realm?.add(storedImage)
                print("insert")
                print(storagedImages as Any)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }

    }

    func deleteFromDatabase(withImageId imageId: Int) {
        let storagedImage = StoragedImage()
        storagedImage.imageId = imageId
        print(storagedImages as Any)
        print(storagedImage)
        storagedImages?.forEach({ (storagedImage) in
            if storagedImage.imageId == imageId {
                do {
                    try realm?.write {
                        realm?.delete(storagedImage)
                        print("delete")
                        print(storagedImages as Any)
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
//        if storagedImages?.contains(storagedImage) ?? false {
//            do {
//                try realm?.write {
//                    realm?.delete(storagedImage)
//                    print("delete")
//                    print(storagedImages as Any)
//                }
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//        } else {
//            print(storagedImages?.contains(storagedImage))
//        }
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
