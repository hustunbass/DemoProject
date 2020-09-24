//
//  TodayWeatherVC.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 24.09.2020.
//

import UIKit
import Alamofire
import SwiftyJSON

class TodayWeatherVC: UITableViewController {

//    MARK: - Variables

    var cityName = ""
    var currentWeather = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
        getTodayResult()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodayWeatherCell", for: indexPath) as! TodayWeatherCell
            
            cell.selectedText.text = "Seçtiğiniz Şehir: \(cityName)"
            
            return cell
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodayWeatherResultCell", for: indexPath) as! TodayWeatherResultCell
            
            cell.resultText.text = currentWeather
            
            return cell
            
        }
        
       
    }
    
    func getTodayResult(){
        
//        api.openweathermap.org/data/2.5/weather?q=London&appid=087c3d068d6cb844c7e4925754b5b18b
        
        if let url = URL(string: "api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=087c3d068d6cb844c7e4925754b5b18b"){
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
                
                if error == nil {
                    if let incomingData = data {
                        
                        do{
                            let jsonResult = try JSONSerialization.jsonObject(with: incomingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            let weather = jsonResult["weather"] as! NSArray
                            let weather1 = weather.firstObject as! [String : AnyObject]
                            
                            if let description = weather1["description"] as? String{
                                
                                print("Seçtiğin şehrin hava durumu \(description)")
                                
                                DispatchQueue.main.sync(execute: {
                                    self.currentWeather = description
                                    self.tableView.reloadData()
                                })
                            }
                        }catch{
                            print("burada hata oluştu")
                        }
                    }
                    
                }
                
            };task.resume()
            
        }
        
    }
   
}
