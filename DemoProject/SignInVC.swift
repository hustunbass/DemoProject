//
//  SignInVC.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 20.09.2020.
//

import UIKit
import Parse

class SignInVC: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//veri ekleme
//        let parseObject = PFObject(className: "Fruits")
//        parseObject["name"] = "Banana"
//        parseObject["calories"] = 150
//        parseObject.saveInBackground { (success, error) in
//            if error != nil {
//
//                print(error?.localizedDescription)
//
//            }else {
//                print("Saved")
//            }
//        }
        
//        veri cekme
//        let query = PFQuery(className: "Fruits")
//        filtreleme
//        query.whereKey("calories", greaterThan: 120)
//        query.whereKey("name", equalTo: "Apple")
//        query.findObjectsInBackground { (objects, error) in
//            if error != nil {
//                print(error?.localizedDescription)
//            }else{
//                print(objects)
//            }
//        }
        
        
    }
    

    @IBAction func signInClicked(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != ""{
            
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user, error) in
                
                if error != nil {
//                    Eger giris sirasinda bir problem olursa alert devreye girer
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
//                    remember user function
                    UserDefaults.standard.setValue(self.userNameText.text!, forKey: "username")
                    UserDefaults.standard.synchronize()

                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberUser()
//                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                    
                }
                
            }
        }else {
//            eger eksik bilgi girilirse alert devreye girer
            let alert = UIAlertController(title: "Error", message: "username or password need !", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        
       
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != ""{

            let user = PFUser()
                user.username = userNameText.text!
                user.password = passwordText.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil {
//Eger kayit sirasinda bir problem olursa alert devreye girer
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }else{
//                    giris esnasında problem yoksa uygulama icine gider
                    
                    UserDefaults.standard.setValue(self.userNameText.text!, forKey: "username")
                    UserDefaults.standard.synchronize()

                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberUser()
//                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                    
                    
                }
            }
            
        }else {
//            eger eksik bilgi girilirse alert devreye girer
            let alert = UIAlertController(title: "Error", message: "username or password need !", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    
    }
}
