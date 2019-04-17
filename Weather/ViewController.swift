//
//  ViewController.swift
//  Weather
//
//  Created by Eric Castronovo on 4/17/19.
//  Copyright © 2019 Eric Castronovo. All rights reserved.
//

import Alamofire
import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    // MARK: IB Outlets & Actions
    @IBOutlet weak var cityField: UITextField!
    @IBAction func fetchInfoButton(_ sender: UIButton) {
        validateInput()
        fetchForecastData()
    }
    
    // MARK: Variables
    
    
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
        
//        let parameters: [String: String] = [
//            "q" : "boston",
//            "cnt" : "10",
//            "APPID" : "831385389d57f1cdcb4d9760f43a520e",
//        ]
//
//        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast/daily", method: .get, parameters: parameters, encoding: JSONEncoding.default)
//            .responseString { response in
//                print(response)
//
//        }
        
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?q=boston&cnt=50&appid=831385389d57f1cdcb4d9760f43a520e").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

