//
//  RealmModel.swift
//  FlowerForever
//
//  Created by mac on 8/2/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import RealmSwift

class StoragedImage: Object {
    @objc dynamic var imageId = 0
    override static func primaryKey() -> String? {
        return "imageId"
    }
}
