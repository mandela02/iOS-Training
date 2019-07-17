//
//  VideoModel.swift
//  PartyRockMansion
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import Foundation
import UIKit

class VideoModel {
    private var _imageAvatarURL: String!
    private var _Title: String!
    private var _videoURL: String!
    
    init(){}
    
    init(imageURL: String, name: String, videoURL: String) {
        self._imageAvatarURL = imageURL
        self._Title = name
        self._videoURL = videoURL
    }
    
    var videoURL: String {
        get {
            return _videoURL
        }
        set {
            if newValue != "" {
                _videoURL = newValue
            }
        }
    }
    
    var title:String{
        get {
            return _Title
        }
        set {
            if newValue != "" {
                _Title = newValue
            }
        }
    }
    
    var imageURL: String{
        get {
            return _imageAvatarURL
        }
        set {
            if newValue != "" {
                _imageAvatarURL = newValue
            }
        }
    }
}
