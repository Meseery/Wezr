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
    var currentLocation : CLLocation! {
        didSet {
            getWeatherForCurrentLocation()
        }
    }
    
    var forecastService = ForecastService()
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupTableView()
    }
    
    func setupTableView()  {
        tableView.dataSource = self
    }
    
    func updateMainUI () {
        dateLabel.text = forecastService.date
        tempLabel.text = "\(String(forecastService.currentTemp))°"
        locationLabel.text = forecastService.cityName
        weatherTypeLabel.text = forecastService.weatherType
        weatherImage.image = UIImage(named: forecastService.weatherType)
        
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
        locationManager.distanceFilter = 300 // prevent multiple location updates
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            self.locationManager.startUpdatingLocation()
        }else if status == .denied || status == .restricted{
            // Set default location = London
            currentLocation = CLLocation(latitude: Double(-0.118092), longitude: Double(51.509865))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count == 0 {
            return
        }
        currentLocation = locations.last
    }
    
    func getWeatherForCurrentLocation()  {
        guard let _ = currentLocation else {
            return
        }
        Location.sharedInstance.latitude = currentLocation.coordinate.latitude
        Location.sharedInstance.longitude = currentLocation.coordinate.longitude
        forecastService.downloadWeather {
            self.downloadForecast() {
                self.updateMainUI()
            }
        }
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
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as? WZForecastCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WZForecastCell()
        }
        
    }
}


