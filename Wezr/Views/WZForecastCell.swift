//
//  WZForecastCell.swift
//  Wezr
//
//  Created by Mohamed EL Meseery on 7/20/17.
//  Copyright © 2017 Meseery. All rights reserved.
//

import UIKit

class WZForecastCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCell(forecast: Forecast) {
        lowTemp.text = "\(String(Int(forecast.lowTemp)))°"
        highTemp.text = "\(String(Int(forecast.highTemp)))°"
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }
}
