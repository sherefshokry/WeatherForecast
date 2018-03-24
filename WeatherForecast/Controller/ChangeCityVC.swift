//
//  ChangeCityVC.swift
//  WeatherForecast
//
//  Created by SherifShokry on 3/14/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit


protocol ChangeCityDelegate {
    func changeCityByName(_ cityName : String)
}

class ChangeCityVC: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var delegate : ChangeCityDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func changeCityBtnPressed(_ sender: Any) {
     
        delegate?.changeCityByName(textField.text!)
        dismiss(animated: true, completion: nil)

    }
    
  
}
