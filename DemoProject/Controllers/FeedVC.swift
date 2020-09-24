//
//  FeedVC.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 20.09.2020.
//

import UIKit
import Parse

class FeedVC : UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    var postOwnerArray = [String]()
    var postCommentArray = [String]()
    var postUUIDArray = [String]()
    var postImageArray = [PFFileObject]()
    
    @IBOutlet weak var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        tabelView.delegate = self
        tabelView.dataSource = self
        
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(FeedVC.getData), name: NSNotification.Name("newPost"), object: nil)
    }
    
    @objc func getData(){
      
        let query = PFQuery(className: "Posts")
//        postlar createdAt ile son atlan post en ustte olacak sekılde sayfada yuklenıyor
        query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground { (objects, error) in
            
            if error != nil{
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
//                daha once ekrana basılmıs postların tekrar basılmaması onlendı
                self.postOwnerArray.removeAll(keepingCapacity: false)
                self.postImageArray.removeAll(keepingCapacity: false)
                self.postUUIDArray.removeAll(keepingCapacity: false)
                self.postCommentArray.removeAll(keepingCapacity: false)
                
                if objects!.count > 0 {
                    
                    for object in objects! {
                        
                        self.postOwnerArray.append(object.object(forKey: "postowner") as! String)
                        self.postCommentArray.append(object.object(forKey: "postcomment") as! String)
                        self.postUUIDArray.append(object.object(forKey: "postuuid") as! String)
                        self.postImageArray.append(object.object(forKey: "postimage") as! PFFileObject)
                        
                    }
                }
                self.tabelView.reloadData()
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postOwnerArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        
//        dizilerdeki veriler cell içindeki textlere ekranda bastırılıyor.
        cell.userNameLabel.text = postOwnerArray[indexPath.row]
        cell.postCommentText.text = postCommentArray[indexPath.row]
        cell.postUUIDLabel.text = postUUIDArray[indexPath.row]
        
        postImageArray[indexPath.row].getDataInBackground { (data, error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
//                atılan posttaki resimde cell ıcıne aktarılıyor
                cell.postImage.image = UIImage(data: data!)
            }
        }
        
        
        return cell
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

