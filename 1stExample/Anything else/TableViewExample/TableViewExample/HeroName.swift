//
//  HeroName.swift
//  TableViewExample
//
//  Created by mac on 7/9/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import Foundation
import UIKit

class HeroName {
    var secretIdentity: String
    var heroName: String
    
    init(RealName identity: String, HeroName hero: String) {
        self.secretIdentity = identity
        self.heroName = hero
    }
}
