//
//  DataVC.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 24.09.2020.
//

import UIKit

class DataVC: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    var displayText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayLabel.text = displayText
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
