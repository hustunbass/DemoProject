//
//  TodayWeatherResultCell.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 24.09.2020.
//

import UIKit

class TodayWeatherResultCell: UITableViewCell {

    
    @IBOutlet weak var resultText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
