//
//  WZCityForecastViewController.swift
//  Wezr
//
//  Created by Mohamed EL Meseery on 7/17/17.
//  Copyright © 2017 Meseery. All rights reserved.
//

import UIKit

class WZCityForecastViewController: UITableViewController {

    var city : City!
    var forecastService  = ForecastService ()
    var forecasts = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let _ = city else {
            print("Handle empty city")
            return
        }
        forecastService.getForecast(forCityID: city.id) { (json) in
            self.forecasts = self.forecastService.parseForecasts(jsonData: json)
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Table view data source
extension WZCityForecastViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return forecasts.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let forecastDate = forecasts[section].forecastTime
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: forecastDate)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.detailTextLabel?.text = "weather"
            cell.textLabel?.text = forecasts[indexPath.row].weatherDescription
        case 1:
            cell.detailTextLabel?.text = "temperature"
            cell.textLabel?.text = String(describing: forecasts[indexPath.row].temperature)
        case 2:
            cell.detailTextLabel?.text = "pressure"
            cell.textLabel?.text = String(describing: forecasts[indexPath.row].pressure)
        default:
            break
        }
        return cell
    }
    
}
