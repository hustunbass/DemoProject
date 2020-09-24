//
//  DovizVC.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 23.09.2020.
//

import UIKit
import Alamofire
import SwiftyJSON
import Parse

class DovizVC: UITableViewController {

    
    var currencies = [Currency]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getLatestData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
   
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return currencies.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dovizCell", for: indexPath) as! DovizCell

//        dovizCell'imizin textlerine dizimizdeki elemanları yazdırıyoruz.
        cell.hisseId.text = String(currencies[indexPath.row].id)
        cell.hisseKod.text = currencies[indexPath.row].kod
        cell.hisseAd.text = currencies[indexPath.row].ad
        cell.hisseTip.text = currencies[indexPath.row].tip


        return cell
    }
    
    
    
//    MARK: - FUNC
    
    
    func getLatestData(){
        
//        alamofire kutuphanesi ile url'imizi get methodu ile çağırıyoruz
        AF.request("http://bigpara.hurriyet.com.tr/api/v1/hisse/list", method: .get).validate().responseJSON { response in
            
            if let data = response.data {
                
                do {
//                    gelen json data'yı dönüştürüyoruz.
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    {
//                        datamızı veriler adlı degiskene atıyoruz
                        if let veriler = json["data"] as? [[String:Any]] {
                            
                            
                            
                            for veri in veriler {
     
//                                yeni bir degisken ile donusturulen json data içindeki veriler tek tek diziye atılıyor
                                let newCurrency = Currency(id: veri["id"]  as! Int,
                                                           kod: veri["kod"] as! String,
                                                           ad:  veri["ad"]  as! String,
                                                           tip: veri["tip"] as! String)
                                
//                                cekilen yedek dizideki veriler ana diziye aktarılıyor.
                                self.currencies.append(newCurrency)
                                
                            }
//                            tableView'i yeniliyoruz
                            self.tableView.reloadData()

                        }
                    }
                } catch  {
//                    hata mesajımız fırlatılıyor
                    print("Json error: \(error.localizedDescription)")
                }
            }

        }
        
    }
    
    

    @IBAction func logOutClicked(_ sender: Any) {
        
        //        let sv = UIViewController.displaySpinner(onView: self.view)
                PFUser.logOutInBackground { (error) in
        //            UIViewController.removeSpinner(spinner: sv)
                    if error != nil {
                        
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{
        //                cıkıs yapılırken user name objesı sılınıyor ve loadSıgnInScreen fonksiyonu ile kayıt&giriş yap sayfasına yonlendırme oluyor.
                        UserDefaults.standard.removeObject(forKey: "username")
                        UserDefaults.standard.synchronize()
                        self.loadSignInScreen()
        //                let signIn = self.storyboard?.instantiateViewController(identifier: "signIn") as! SignInVC
        //
        //                let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //
        //                delegate.window?.rootViewController = signIn
                        
        //                delegate.rememberUser()
                        
                    }
                }
                
        
    }
    
    func loadSignInScreen(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "signIn") as! SignInVC
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    

}
