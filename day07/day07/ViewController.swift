//
//  ViewController.swift
//  day07
//
//  Created by Oleksandr MALTSEV on 7/3/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit
import ForecastIO
import RecastAI

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var rsponse: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var bot : RecastAIClient?
    let client = DarkSkyClient(apiKey: "5ddda1813346c4f7f692ed96ab65d4d9")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bot = RecastAIClient(token: "6a878c516df22fb0ca451588f8693024", language: "en")
        client.units = .si
    }
    
    @IBAction func requestButton(_ sender: UIButton) {
        if textField.text != "" {
        self.bot?.textRequest(textField.text!, successHandler: { (response) in
            let location = response.get(entity: "location")
            if (location != nil) {
                let lat = location!["lat"]?.doubleValue
                let lng = location!["lng"]?.doubleValue
//                print("lat", lat as Any, "lng", lng as Any)
                if (lat != nil) {
                    self.makeRequest(lat: lat!, lng: lng!)
                } else {
                    self.rsponse.text = "Error with Recast API try again"
                }
            } else {
                self.rsponse.text = "Enter a valid city"
            }
            
        }, failureHandle: { (error) in
            self.rsponse.text = "Error with Recast call"
        })
        } else {
            rsponse.text = "Enter a Country or City"
        }
    }
    
    func makeRequest(lat: Double, lng: Double) {
        client.getForecast(latitude: lat, longitude: lng) { result in
            switch result {
            case .success(let currentForecast, _):
                let summary = currentForecast.currently?.summary
                let temperature = currentForecast.currently?.temperature
                let resTemp = Int(temperature!)
                DispatchQueue.main.async {
                    self.rsponse.text = summary! + ", \(resTemp) C"
                }
            case .failure:
                DispatchQueue.main.async {
                    self.rsponse.text = "Error with Weather API"
                }
            }
        }

    }
    
    
}

