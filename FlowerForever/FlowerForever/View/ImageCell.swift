//
//  ImageCell.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var userInformationView: UIView!
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateCellUi(image: Image) {
        imageHeightConstraint.constant = UIScreen.main.bounds.width * CGFloat(image.aspectRatio)
        userImageView.maskCircle()
        flowerImageView.image = nil
        flowerImageView.downloaded(from: image.largeImageURL)
        userNameLabel.text = image.user
        userImageView.downloaded(from: image.userImageURL)
    }
}
