//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Eric Castronovo on 4/17/19.
//  Copyright © 2019 Eric Castronovo. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    // MARK: IB Outlets
    
    @IBOutlet weak var forecastDay: UILabel!
    @IBOutlet weak var tempLow: UILabel!
    @IBOutlet weak var tempHigh: UILabel!
    @IBOutlet weak var forecastIcon: UIImageView!
    @IBOutlet weak var forecastDescription: UILabel!
    
    
    // MARK: Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Inserts cell with weather data
    func populateCell(data: WeatherData){
        self.forecastDay.text = "\(data.getDate)"
        self.tempLow.text = "\(data.getLowTemp)"
        self.tempHigh.text = "\(data.getHighTemp)"
        self.forecastIcon.image = data.getIcon
        self.forecastDescription.text = "\(data.getDescription)"
    }
}
