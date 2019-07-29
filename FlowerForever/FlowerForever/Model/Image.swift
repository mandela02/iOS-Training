//
//  File.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import Alamofire

class Image {
    private var _largeImageURL: String!
    private var _imageWidth: Double!
    private var _imageHeight: Double!
    private var _user: String!
    private var _userImageURL: String!
    private var _isLiked: Bool!

    var isLiked: Bool {
        get {
            if _isLiked == nil {
                _isLiked = false
            }
            return _isLiked
        }
        set {
            _isLiked = newValue
        }
    }

    var userImageURL: String {
        get {
            if _userImageURL == nil {
                _userImageURL = ""
            }
            return _userImageURL
        }
        set {
            _userImageURL = newValue
        }
    }

    var user: String {
        get {
            if _user == nil {
                _user = ""
            }
            return _user
        }
        set {
            _user = newValue
        }
    }

    var largeImageURL: String {
        get {
            if _largeImageURL == nil {
                _largeImageURL = ""
            }
            return _largeImageURL
        }
        set {
            _largeImageURL = newValue
        }
    }

    var imageWidth: Double {
        get {
            if _imageWidth == nil {
                _imageWidth = 0.0
            }
            return _imageWidth
        }
        set {
            _imageWidth = newValue
        }
    }

    var imageHeight: Double {
        get {
            if _imageHeight == nil {
                _imageHeight = 0.0
            }
            return _imageHeight
        }
        set {
            _imageHeight = newValue
        }
    }

    var aspectRatio: Double {
        if imageWidth == 0 {
            return 1/1
        } else {
            return imageHeight/imageWidth
        }
    }

    init(imageData: [String: AnyObject]) {
        if let largeImageURL = imageData["largeImageURL"] as? String {
            self.largeImageURL = largeImageURL
            //print(largeImageURL)
        }
        if let imageWidth = imageData["imageWidth"] as? Double {
            self.imageWidth = imageWidth
        }
        if let imageHeight = imageData["imageHeight"] as? Double {
            self.imageHeight = imageHeight
        }
        if let user = imageData["user"] as? String {
            self.user = user
        }
        if let userImageURL = imageData["userImageURL"] as? String {
            self.userImageURL = userImageURL
        }
    }
}
