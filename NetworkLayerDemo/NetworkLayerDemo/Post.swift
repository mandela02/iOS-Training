//
//  Post.swift
//  NetworkLayerDemo
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation

struct Post: Codable {
    let id: Int
    let titleName: String
    let body: String
    let userId: Int
}
