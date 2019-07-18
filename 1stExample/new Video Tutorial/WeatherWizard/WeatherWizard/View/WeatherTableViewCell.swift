//
//  WeatherCell.swift
//  WeatherWizard
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherMiniImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateCellUI(broadcastData: Forecast) {
        dateLabel.text = broadcastData.date
        statusLabel.text = broadcastData.status
        maxTemperatureLabel.text = broadcastData.maxTemp
        minTemperatureLabel.text = broadcastData.minTemp
        weatherMiniImage.image = UIImage(named: broadcastData.status)
    }
}
