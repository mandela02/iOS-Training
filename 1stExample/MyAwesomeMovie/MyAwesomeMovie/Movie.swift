//
//  Movie.swift
//  MyAwesomeMovie
//
//  Created by mac on 7/20/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation

class Movie {
    var _posterPath: String!
    var _title: String!
    var _genres: String!
    var _score: String!
    var _releaseDate: String!
    var _overview: String!
    var _posterUrl: String!
    
    var posterPath: String {
        get {
            if _posterPath == nil {
                _posterPath = ""
            }
            return _posterPath
        }
        set {
            _posterPath = newValue
        }
    }
    
    var title: String {
        get {
            if _title == nil {
                _title = ""
            }
            return _title
        }
        set {
            _title = newValue
        }
    }
    
    var genres: String {
        get {
            if _genres == nil {
                _genres = ""
            }
            return _genres
        }
        set {
            _genres = newValue
        }
    }
    
    var score: String {
        get {
            if _score == nil {
                _score = ""
            }
            return _score
        }
        set {
            _score = newValue
        }
    }
    
    var releaseDate: String {
        get {
            if _releaseDate == nil {
                _releaseDate = ""
            }
            return _releaseDate
        }
        set {
            _releaseDate = newValue
        }
    }
    
    var overview: String {
        get {
            if _overview == nil {
                _overview = ""
            }
            return _overview
        }
        set {
            _overview = newValue
        }
    }
    
    var posterUrl: String {
        if _posterPath == nil {
            _posterUrl = ""
        }
        else {
            _posterUrl = Const.imagePath + self.posterPath
        }
        return _posterUrl
    }
}

