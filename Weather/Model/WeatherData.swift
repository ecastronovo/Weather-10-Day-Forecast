//
//  WeatherData.swift
//  Weather
//
//  Created by Eric Castronovo on 4/17/19.
//  Copyright © 2019 Eric Castronovo. All rights reserved.
//

import Foundation
import Alamofire

class WeatherData {
    
    // MARK: Variables
    
    private var date: String!
    private var description: String!
    private var icon: UIImage!
    private var highTemp: Double!
    private var lowTemp: Double!
    
    // MARK: Initializer
    
    init(dict: Dictionary<String, AnyObject>){
        // retrieves the max and min temperature
        // converts max and min to Fahrenheit
        if let temperatureDict = dict["temp"] as? Dictionary<String, AnyObject>{
            if let highTemp = temperatureDict["max"] as? Double {
                let convertedHighTemp = convertToFahrenheit(tempInKelvin: highTemp)
                self.highTemp = convertedHighTemp
            }
            if let lowTemp = temperatureDict["min"] as? Double {
                let convertedLowTemp = convertToFahrenheit(tempInKelvin: lowTemp)
                self.lowTemp = convertedLowTemp
            }
        }
        // retrieves the weather icon code and main message
        // selects correct icon
        if let weatherDict = dict["weather"] as? [Dictionary<String, AnyObject>]{
            let weatherInfo = weatherDict[0]
            if let main = weatherInfo["main"] as? String {
                self.description = main
            }
            if let id = weatherInfo["id"] as? Int {
                let iconGraphic = iconPicker(idCode: id)
                self.icon = iconGraphic
            }
        }
        // retrieves epoch time
        // converts to day of week
        if let date = dict["dt"] as? Double {
            let day = convertEpochToDay(dayInEpoch: date)
            self.date = day
        }
    }
    
    // MARK: Supporting Functions
    
    // converts condition code to image
    func iconPicker(idCode: Int) -> UIImage{
        if idCode >= 200 && idCode < 300{
            return #imageLiteral(resourceName: "lightning")
        }
        else if idCode >= 300 && idCode < 600{
            return #imageLiteral(resourceName: "raining")
        }
        else if idCode >= 600 && idCode < 700{
            return #imageLiteral(resourceName: "snowy")
        }
        else if idCode >= 700 && idCode < 800{
            return #imageLiteral(resourceName: "cloudy")
        }
        else if idCode == 800{
            return #imageLiteral(resourceName: "sunny")
        }
        else {
            return #imageLiteral(resourceName: "clouds")
        }
    }
    
    // converts Kelvin to Fahrenheit
    func convertToFahrenheit(tempInKelvin:Double) -> Double {
        var fahrenheit = tempInKelvin - 273.15
        fahrenheit *= (9/5)
        fahrenheit += 32
        fahrenheit = round(10*fahrenheit)/10
        return fahrenheit
    }
    
    // converts epoch time to day of week
    func convertEpochToDay(dayInEpoch: Double) -> String{
        let dayOfWeek = Date(timeIntervalSince1970: dayInEpoch)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: dayOfWeek)
    }
    
    // MARK: Getters & default value methods
    
    var getDate: String {
        if date == nil {
            date = ""
            return date
        }
        return date
    }
    var getDescription: String {
        if description == nil {
            description = ""
        }
        return description
    }
    var getIcon: UIImage {
        if icon == nil {
            icon = #imageLiteral(resourceName: "sunny")
        }
        return icon
    }
    var getHighTemp: Double {
        if highTemp == nil {
            highTemp = 0.0
        }
        return highTemp
    }
    var getLowTemp: Double {
        if lowTemp == nil {
            lowTemp = 0.0
        }
        return lowTemp
    }
}
