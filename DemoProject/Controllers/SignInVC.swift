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
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        
        signInButton.layer.cornerRadius = 7
        signInButton.layer.masksToBounds = true
        
        signUpButton.layer.cornerRadius = 7
        signUpButton.layer.masksToBounds = true
        
        
        

    }
    
//    Kullanıcı gırıs yaptıysa direkt tab var acılsın
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = PFUser.current()
        if currentUser != nil{
            loadHomeScreen()
        }
    }
    
    
    func loadHomeScreen(){
    

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "feedVC") as! FeedVC
        let mainTabBarController = storyBoard.instantiateViewController(identifier: "tabBar")
        mainTabBarController.modalPresentationStyle = .fullScreen
        self.present(mainTabBarController, animated: true, completion: nil)
        
        
        
    }
    

    @IBAction func signInClicked(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != ""{
            
            let sv = UIViewController.displaySpinner(onView: self.view)
            
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user, error) in
                
                UIViewController.removeSpinner(spinner: sv)
                
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
                    self.loadHomeScreen()
//                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
//                    delegate.rememberUser()
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
            
            let sv = UIViewController.displaySpinner(onView: self.view)
            user.signUpInBackground { (success, error) in
                UIViewController.removeSpinner(spinner: sv)
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
                    self.loadHomeScreen()

//                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
//                    delegate.rememberUser()
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

extension UIViewController {
 class func displaySpinner(onView : UIView) -> UIView {
     let spinnerView = UIView.init(frame: onView.bounds)
     spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
     let ai = UIActivityIndicatorView.init(style: .large)
     ai.startAnimating()
     ai.center = spinnerView.center

     DispatchQueue.main.async {
         spinnerView.addSubview(ai)
         onView.addSubview(spinnerView)
     }

     return spinnerView
 }

 class func removeSpinner(spinner :UIView) {
     DispatchQueue.main.async {
         spinner.removeFromSuperview()
     }
 }
}
