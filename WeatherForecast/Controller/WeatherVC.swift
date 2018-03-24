//
//  WeatherVC.swift
//  WeatherForecast
//
//  Created by SherifShokry on 3/14/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire

class WeatherVC: UIViewController ,  CLLocationManagerDelegate ,  UITableViewDelegate , UITableViewDataSource ,  ChangeCityDelegate   {
   
    
   
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var temprature: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    
    @IBOutlet weak var forecastTableView: UITableView!
    let   locationManager = CLLocationManager()
    let APP_ID = "7e68e8eeb2834747a6cd0fd4f48e2538"
    let URL = "https://api.weatherbit.io/v2.0/forecast/daily?"
    var weatherDataModel = WeatherDataModel()
    var weatherForecastData : [ WeatherDataModel ] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    

    
    func requestWeatherData(_ params : [String : String])
    {
    Alamofire.request(URL, method: .get, parameters: params).responseJSON
        {
            response in
            if response.result.isSuccess {
                print(response.value!)
                
             let json = JSON(response.value!)
              self.parseJsonData(json)
             
            }
            else {
                self.cityName.text = "Connection Issues"
             }
            
        }
    }
    
    
    
    func parseJsonData(_ json : JSON) {
       weatherForecastData = []
        for index in 0...15 {
            weatherDataModel = WeatherDataModel()
        self.weatherDataModel.cityName = json["city_name"].string!
        self.weatherDataModel.temprature = json["data"][index]["temp"].int!
        self.weatherDataModel.weatherDescription = json["data"][index]["weather"]["description"].string!
        self.weatherDataModel.weatherImage = json["data"][index]["weather"]["icon"].string!
        self.weatherDataModel.date = json["data"][index]["datetime"].string!
      
            weatherForecastData.append(weatherDataModel)
            
        }
        
            updateUiElement()
        
    }
    
    func updateUiElement()
    {
        cityName.text = weatherForecastData[0].cityName
        temprature.text = String(weatherForecastData[0].temprature) + "°"
        weatherDescription.text = weatherForecastData[0].weatherDescription
        weatherIcon.image = UIImage(named: weatherForecastData[0].weatherImage)
  
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
         forecastTableView.reloadData()
    }
    
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
  
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0
        {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        
        let longitude = String(location.coordinate.longitude)
        let latitude = String(location.coordinate.latitude)
            
            let params : [String : String] = ["lat" : latitude , "lon" : longitude , "key" : APP_ID]
            
            requestWeatherData(params)
        }
      
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        cityName.text = "Location Unavailable"
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath)
            as? TableViewCell
        
        cell?.weatherDescription.text = weatherForecastData[indexPath.row + 1].weatherDescription
        cell?.temprature.text = String(weatherForecastData[indexPath.row + 1].temprature) + "°"
        cell?.weatherIcon.image = UIImage(named: weatherForecastData[indexPath.row + 1].weatherImage)
        cell?.date.text = weatherForecastData[indexPath.row + 1 ].date
        
        return cell!
    }
   

    @IBAction func switchBtnPressed(_ sender: Any) {
   
        performSegue(withIdentifier: "changeCitySegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? ChangeCityVC
        destination?.delegate = self
 
    }
    
    
    func changeCityByName(_ cityName: String) {
       let params : [String : String] = [ "city" : cityName , "key" : APP_ID]
        requestWeatherData(params)
        
    }
    
}

