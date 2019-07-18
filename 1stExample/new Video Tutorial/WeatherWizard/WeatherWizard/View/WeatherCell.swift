//
//  WeatherCell.swift
//  WeatherWizard
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var imgWeatherMini: UIImageView!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblMinTemperature: UILabel!
    @IBOutlet weak var lblMaxTemperature: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCellUI(broadcastData: Forecast) {
        lblDay.text = broadcastData.date
        lblStatus.text = broadcastData.status
        lblMaxTemperature.text = broadcastData.maxTemp
        lblMinTemperature.text = broadcastData.minTemp
        imgWeatherMini.image = UIImage(named: broadcastData.status)
    }

}
