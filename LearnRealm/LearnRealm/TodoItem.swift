//
//  model.swift
//  LearnRealm
//
//  Created by mac on 8/2/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    @objc dynamic var detail = ""
    @objc dynamic var status = 0
}
