//
//  ViewController.swift
//  WeatherWizard
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

    @IBOutlet weak var imgWeatherStatus: UIImageView!
    @IBOutlet weak var lblWeatherStatus: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var tblBroadcast: UITableView!

    let weather = CurrentWeather()
    let broadcast = BroadcastData()
    var itemCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weather.downloadWeatherData {
            self.updateUI()
        }
        tblBroadcast.delegate = self
        tblBroadcast.dataSource = self
    }
    
    func updateUI() {
        imgWeatherStatus.image = UIImage(named: weather.weatherStatus)
        lblLocation.text = weather.location
        lblWeatherStatus.text = weather.weatherStatus
        lblDate.text = weather.currentDate
        lblTemperature.text = weather.temperature
    }
}

extension WeatherVC: UITableViewDelegate {}

extension WeatherVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? WeatherCell else
        {
            fatalError()
        }
        broadcast.downloadBroadcastData {
            self.updateCell(cell: cell, cellForRowAt: indexPath)
        }
        return cell
    }
    func updateCell(cell: WeatherCell, cellForRowAt indexPath: IndexPath) {
        cell.updateCellUI(broadcastData: broadcast.listOfBroadcast[indexPath.row])
    }
    
    func getItemCount() -> Int {
        return broadcast.listOfBroadcast.count
    }
}

