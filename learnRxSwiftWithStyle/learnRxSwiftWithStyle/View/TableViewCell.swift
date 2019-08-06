//
//  TableViewCell.swift
//  learnRxSwiftWithStyle
//
//  Created by mac on 8/5/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadUI(withFriend friend: Friend) {
        numberLabel.text = friend.number
        nameLabel.text = friend.name
    }

}
