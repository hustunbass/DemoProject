//
//  DovizVC.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 23.09.2020.
//

import UIKit
import Alamofire
import SwiftyJSON

class DovizVC: UITableViewController {

    
    var currencies = [Currency]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getLatestData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currencies.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dovizCell", for: indexPath) as! DovizCell

        cell.hisseAd.text = currencies[indexPath.row].ad
        cell.hisseKod.text = currencies[indexPath.row].kod
        cell.hisseId.text = String(currencies[indexPath.row].id)
        cell.hisseTip.text = currencies[indexPath.row].tip
        // Configure the cell...

        return cell
    }
    
    
    
//    MARK: - FUNC
    
    
    func getLatestData(){
        
        AF.request("https://bigpara.hurriyet.com.tr/api/v1/hisse/list", method: .get).validate(statusCode: 200..<299).responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                print(json)
                
                for index in 0...json.count{
                    
                    let newCurrency = Currency(id:  json[index]["id"].intValue,
                                               kod: json[index]["kod"].stringValue,
                                               ad:  json[index]["ad"].stringValue,
                                               tip: json[index]["tip"].stringValue)
                    
                    self.currencies.append(newCurrency)
                    
                }
                
                self.tableView.reloadData()
                
                print(self.currencies)
                
                
            case .failure(let error):
                print(error)
            }
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
