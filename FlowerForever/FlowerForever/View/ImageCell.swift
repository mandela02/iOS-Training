//
//  ImageCell.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateCellUi(flower: Flower) {
        indicator.isHidden = true
        flowerImageView.downloaded(from: flower.largeImageUrl)
    }
}
