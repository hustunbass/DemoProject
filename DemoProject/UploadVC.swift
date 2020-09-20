//
//  UploadVC.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 20.09.2020.
//

import UIKit

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
        print("clicked")
    }
    
    
}
