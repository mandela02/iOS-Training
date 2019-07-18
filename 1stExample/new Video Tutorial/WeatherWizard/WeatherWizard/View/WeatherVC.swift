//
//  ViewController.swift
//  WeatherWizard
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {
    
    enum WeatherSection: Int, CaseIterable {
        case Rain = 0, Clear
    }
    
    let SectionHeaderHeight: CGFloat = 25

    @IBOutlet weak var imgWeatherStatus: UIImageView!
    @IBOutlet weak var lblWeatherStatus: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var tblBroadcast: UITableView!

    let weather = CurrentWeather()
    let forecast = ForecastData()
    var groupWeatherdata: [WeatherSection: [Forecast]] = [:]

    //1 time job
    override func viewDidLoad() {
        super.viewDidLoad()
        weather.downloadWeatherData {
            self.forecast.downloadBroadcastData {
                self.updateUI()
                for item in WeatherSection.allCases {
                    self.groupData(section: item)
                }
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
    
    func groupData(section: WeatherSection) {
        groupWeatherdata[section] = forecast.listOfForecastData.filter({ (Forecast) -> Bool in
            switch section {
            case .Rain:
                return Forecast.status == "Rain"
            case .Clear:
                return Forecast.status == "Clear"
            }
        })
    }
}

extension WeatherVC: UITableViewDelegate {
}

extension WeatherVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = WeatherSection(rawValue: section), let weatherData = groupWeatherdata[tableSection] {
            return weatherData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? WeatherCell else {
            fatalError()
        }
        
        if let tableSection = WeatherSection(rawValue: indexPath.section), let weatherData = groupWeatherdata[tableSection]?[indexPath.row]{
            switch tableSection{
            case .Rain:
                cell.updateCellUI(broadcastData: weatherData)
            case .Clear:
                cell.updateCellUI(broadcastData: weatherData)
            }
        }
        //cell.updateCellUI(broadcastData: forecast.listOfForecastData[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return WeatherSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SectionHeaderHeight
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
//        let label = UILabel()
//        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5)
//        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 5)
//        label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        label.textColor = .black
//        label.text = "Weather"
//        label.text = "Weather"
//        return view
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let tableSection = WeatherSection(rawValue: section) {
            switch tableSection {
            case .Rain:
                return "Raining Day"
            case .Clear:
                return "Clear Day"
            }
        }
        else {
            return "Happy Death Day"
        }
    }
}

