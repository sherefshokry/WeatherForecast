//
//  TableViewCell.swift
//  WeatherForecast
//
//  Created by SherifShokry on 3/15/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var temprature: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
