//
//  Cell.swift
//  PrefetchingForTableview
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
