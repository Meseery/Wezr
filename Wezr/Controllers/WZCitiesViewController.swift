//
//  WZCitiesViewController.swift
//  Wezr
//
//  Created by Mohamed EL Meseery on 7/17/17.
//  Copyright © 2017 Meseery. All rights reserved.
//

import UIKit

class WZCitiesViewController: UITableViewController {

    var cityService = CityService()
    var cities = [City]() {
        didSet {
            cities.sort { $0.name < $1.name }
        }
    }
    var searchBar: UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        getCities()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar?.becomeFirstResponder()
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar?.delegate = self
        searchBar?.frame.size.height = 40
        searchBar?.placeholder = "Enter town or city"
        tableView.tableHeaderView = searchBar
    }
    
    func getCities() {
        cityService.getCities(matching: "") { (results) in
            self.cities = results
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UISearchBarDelegate
extension WZCitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cityService.getCities(matching: searchText) { (results) in
            self.cities = results
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table view data source
extension WZCitiesViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row].name
        return cell
    }
    
}

// MARK: - Navigation
extension WZCitiesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showForecast",
            let selectedRow = tableView.indexPathForSelectedRow?.row,
            let destinationVC = segue.destination as? WZCityForecastViewController else { return }
            destinationVC.city = cities[selectedRow]

    }
}
