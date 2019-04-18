//
//  ViewController.swift
//  Weather
//
//  Created by Eric Castronovo on 4/17/19.
//  Copyright © 2019 Eric Castronovo. All rights reserved.
//

import Alamofire
import UIKit

class ViewController: UIViewController {
    
    // MARK: IB Outlets & Actions
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var displayCityName: UILabel!
    @IBAction func fetchInfoButton(_ sender: UIButton) {
        if !validateInput() {
            return
        }
        fetchForecastData()
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: API Variables
    var APIKey:String = "831385389d57f1cdcb4d9760f43a520e"
    var APIParam = "appid="
    var URL:String = "http://api.openweathermap.org/data/2.5/forecast/daily?q="
    var cityName:String = ""
    var URLCountParam: String = "&cnt=10&"
    
    
    // MARK: Variables
    
    var dayForecase: WeatherData!
    var tenDayForecast = [WeatherData]()
    
    
    // MARK: Methods
    
    private func validateInput() -> Bool{
        let inputText = cityField.text
        if inputText == ""{
            let alertController = UIAlertController(title: "Input Error:", message: "Blank Input Field", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        return true
    }
    
    
    private func fetchForecastData(){

        cityName = String(cityField.text!)
        let adjustedCityName = cityName.replacingOccurrences(of: " ", with: "+")
        
        // Constructed URL
        let requestURL:String = URL + adjustedCityName + URLCountParam + APIParam + APIKey
    
        // Alamofire Request and Error handler
        Alamofire.request(requestURL).responseJSON { (response) in
            let result = response.result
            if let dictionary = result.value as? Dictionary<String, AnyObject> {
                if let responseCode = dictionary["cod"] as? String{
                    if responseCode != "200"{
                        var errorMessage = "Error Code \(responseCode)"
                        if responseCode == "404"{
                            errorMessage = "City Not Found"
                        }
                        let alertController = UIAlertController(title: "Response Error:", message: errorMessage, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        self.present(alertController, animated: true, completion: nil)
                        return
                    }
                }
                
                // Call helpers to insert information
                if let list = dictionary["list"] as? [Dictionary<String,AnyObject>] {
                    self.tenDayForecast.removeAll()
                    self.updateTableViewName()
                    for li in list {
                        let forecast = WeatherData(dict: li)
                        self.tenDayForecast.append(forecast)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //updates Display Name and makes visible
    func updateTableViewName(){
        displayCityName.isHidden = false
        displayCityName.text = cityName
    }

    func callDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        callDelegates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//Extention of ViewController to help handle the TableView with TableView's required functions
extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell") as! ForecastTableViewCell
        
        cell.populateCell(data: tenDayForecast[indexPath.row] )
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return tenDayForecast.count
    }
}
