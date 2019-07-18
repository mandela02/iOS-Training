//
//  ViewController.swift
//  WeatherWizard
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    enum WeatherSection: Int, CaseIterable {
        case rain = 0, clear
    }

    let sectionHeaderHeight: CGFloat = 25

    @IBOutlet weak var weatherStatusImage: UIImageView!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var forecastTable: UITableView!

    let weather = CurrentWeather()
    let forecast = ForecastData()
    var groupWeatherdata: [WeatherSection: [Forecast]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        weather.downloadWeatherData {
            self.forecast.downloadForecastData {
                self.updateUI()
                for item in WeatherSection.allCases {
                    self.groupData(section: item)
                }
                self.forecastTable.reloadData()
            }
        }
        forecastTable.dataSource = self
        forecastTable.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        print(Url.currentWeatherUrl)
        print(Url.forecastUrl)
    }

    private func updateUI() {
        weatherStatusImage.image = UIImage(named: weather.weatherStatus)
        locationLabel.text = weather.location
        weatherStatusLabel.text = weather.weatherStatus
        dateLabel.text = weather.currentDate
        temperatureLabel.text = weather.temperature
    }

    private func groupData(section: WeatherSection) {
        groupWeatherdata[section] = forecast.listOfForecastData.filter({ (forecast) -> Bool in
            switch section {
            case .rain:
                return forecast.status == "Rain"
            case .clear:
                return forecast.status == "Clear"
            }
        })
    }
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? WeatherTableViewCell  else {
            return
        }
        let date = cell.dateLabel.text
        let status = cell.statusLabel.text
        let alertController = UIAlertController(title: date!, message: status!, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        alertController.addAction(defaultAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = WeatherSection(rawValue: section), let weatherData = groupWeatherdata[tableSection] {
            return weatherData.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? WeatherTableViewCell else {
            fatalError()
        }
        if let tableSection = WeatherSection(rawValue: indexPath.section),
            let weatherData = groupWeatherdata[tableSection]?[indexPath.row] {
            switch tableSection {
            case .rain:
                cell.updateCellUI(broadcastData: weatherData)
            case .clear:
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
        return sectionHeaderHeight
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
            case .rain:
                return "Raining Day"
            case .clear:
                return "Clear Day"
            }
        } else {
            return "Happy Death Day"
        }
    }
}
