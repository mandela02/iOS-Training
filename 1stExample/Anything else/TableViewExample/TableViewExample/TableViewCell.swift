//
//  TableViewCell.swift
//  TableViewExample
//
//  Created by mac on 7/9/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var mIdentity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
