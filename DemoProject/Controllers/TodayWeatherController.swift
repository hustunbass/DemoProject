//
//  TodayWeatherController.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 24.09.2020.
//

import UIKit

class TodayWeatherController: UIViewController {

    @IBOutlet weak var cityName: UITextField!
    
    @IBOutlet weak var showButton: UIButton!
    
    
    
    @IBAction func goToTodayWeather(_ sender: Any) {
        if cityName.text == "" {
            
            let alert = UIAlertController(title: "Hata var", message: "Lütfen şehir adını boş bırakmayınız", preferredStyle:.alert)
            let cancelButton = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
            
        }else{
            
            let vc = self.storyboard?.instantiateViewController(identifier: "TodayWeatherStoryboardID") as! TodayWeatherVC
            
            vc.cityName = self.cityName.text!
            
            self.show(vc, sender: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showButton.layer.cornerRadius = 4
        showButton.layer.masksToBounds = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

   

}
