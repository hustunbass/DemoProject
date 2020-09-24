//
//  UploadVC.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 20.09.2020.
//

import UIKit
import  Parse

class UploadVC : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var commandText: UITextField!
    
   
    @IBOutlet weak var postButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        klavye acildiginda ekranin herhangi bir yerine tiklayinca kapatilmasi aksiyonu
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action:#selector(hideKeyboard))
        self.view.addGestureRecognizer(keyboardRecognizer)
        
//        kullanicin resime tiklamasina izin
        postImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        postImage.addGestureRecognizer(gestureRecognizer)
        
       postButton.isEnabled = false
        
    }
    
    
    
    @objc func choosePhoto(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        sectigimiz resmi imageview'e aktariyoruz
        postImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        postButton.isEnabled = true
    }
    
    @objc func hideKeyboard(){
        
        self.view.endEditing(true)
    }
    
  
    @IBAction func postClicked(_ sender: Any) {
                postButton.isEnabled = false
                
        let object = PFObject(className: "Posts")
        
        let data = postImage.image?.jpegData(compressionQuality: 0.5)
        let pfImage = PFFileObject(name: "image", data: data!)
        
        let uuid = UUID().uuidString
        let uuidpost = "\(uuid) \(PFUser.current()!.username!)"
        
        
        object["postimage"] = pfImage
        object["postcomment"] = commandText.text
        object["postowner"] = PFUser.current()!.username!
        object["postuuid"] = uuidpost
        
        object.saveInBackground { (success, error) in
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                self.commandText.text = ""
                self.postImage.image = UIImage(named: "select")
                self.tabBarController?.selectedIndex = 0
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPost"), object: nil)
            }
        }
        
        
    }
    

    
    
    
}
