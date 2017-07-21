//
//  WZMainViewController.swift
//  Wezr
//
//  Created by Mohamed EL Meseery on 7/20/17.
//  Copyright © 2017 Meseery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WZMainViewController: UIViewController {

    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    
    var currentWeather = Weather()
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        locationAuthorizationStatus()
    }
    
    func setupTableView()  {
        tableView.dataSource = self
    }
    
    func updateMainUI () {
        dateLabel.text = currentWeather.date
        tempLabel.text = "\(String(currentWeather.currentTemp))°"
        locationLabel.text = currentWeather.cityName
        weatherTypeLabel.text = currentWeather.weatherType
        weatherImage.image = UIImage(named: currentWeather.weatherType)
        
        loadingImageView.isHidden = true
        loadingIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

// MARK: - LocationManager Setup
extension WZMainViewController:CLLocationManagerDelegate {
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationAuthorizationStatus () {
        var notGotLocation = true
        repeat {
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
                notGotLocation = false
                currentLocation = locationManager.location
                Location.sharedInstance.latitude = currentLocation.coordinate.latitude
                Location.sharedInstance.longitude = currentLocation.coordinate.longitude
                currentWeather.downloadWeather {
                    self.downloadForecast() {
                        self.updateMainUI()
                    }
                }
            }
        } while(notGotLocation)
        
    }
    
    func downloadForecast(completed: @escaping DownloadComplete){
        
        let apiCall = ForecastResource(lat: Location.sharedInstance.latitude, lon: Location.sharedInstance.longitude)
        let forecastURL = URL(string: apiCall.forecastURL)
        Alamofire.request(forecastURL!).responseJSON { response in
            
            if let data = response.data {
                let json = JSON(data: data)
                for obj in json["list"].array! {
                    
                    let low = obj["temp"]["min"].double!.KtoF()
                    let high = obj["temp"]["max"].doubleValue.KtoF()
                    let type = obj["weather"][0]["main"].stringValue
                    let date = Date(timeIntervalSince1970: obj["dt"].doubleValue).dayOfTheWeek()
                    
                    self.forecasts.append(Forecast(low, high, type, date))
                    
                }
                
                self.forecasts.remove(at: 0)
                self.tableView.reloadData()
            }
            
            }.response { _ in completed() }
    }
}

// MARK: - TableView Datasource
extension WZMainViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? WZForecastCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WZForecastCell()
        }
        
    }
}


