//
//  DovizCell.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 23.09.2020.
//

import UIKit

class DovizCell: UITableViewCell {

//    MARK: - IBOUTLEST
    
    
    @IBOutlet weak var hisseAd: UILabel!
    @IBOutlet weak var hisseKod: UILabel!
    @IBOutlet weak var hisseId: UILabel!
    @IBOutlet weak var hisseTip: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
