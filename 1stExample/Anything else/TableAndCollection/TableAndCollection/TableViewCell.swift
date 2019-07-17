//
//  TableViewCell.swift
//  TableAndCollection
//
//  Created by mac on 7/11/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var mBlueLabel: UILabel!
    @IBOutlet weak var mRedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
