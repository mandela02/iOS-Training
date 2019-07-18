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
    let forecast = ForecastData()

    //1 time job
    override func viewDidLoad() {
        super.viewDidLoad()
        weather.downloadWeatherData {
            self.forecast.downloadBroadcastData {
                self.updateUI()
                self.tblBroadcast.reloadData()
            }
        }
        tblBroadcast.dataSource = self
        tblBroadcast.delegate = self
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
        return forecast.listOfForecastData.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? WeatherCell else {
            fatalError()
        }
        
        
        cell.updateCellUI(broadcastData: forecast.listOfForecastData[indexPath.row])
        return cell
    }
}

