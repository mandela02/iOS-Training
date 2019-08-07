//
//  TableViewCell.swift
//  FlowerForeverMVVM
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateUI(hit: Hit) {
        mainImageView.image = nil
        imageHeightConstraint.constant = UIScreen.main.bounds.width * CGFloat(hit.imageHeight/hit.imageWidth)
        mainImageView.downloaded(from: hit.largeImageURL)
    }

}
