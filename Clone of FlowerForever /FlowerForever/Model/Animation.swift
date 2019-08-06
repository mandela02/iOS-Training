//
//  Animation.swift
//  FlowerForever
//
//  Created by mac on 7/30/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import UIKit

class Animation {
    func fadeOut(imageView: UIImageView ) {
        imageView.isHidden = false
        imageView.image = UIImage(named: "likeWhite")
        imageView.alpha = 1.0
        UIView.animate(withDuration: 1.0, animations: {
            imageView.alpha = 0.0
        }) { _ in
            imageView.isHidden = true
        }
    }
}
