//
//  FeedCell.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 21.09.2020.
//

import UIKit
import Parse
class FeedCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postUUIDLabel: UILabel!
    
    @IBOutlet weak var postCommentText: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postUUIDLabel.isHidden = true
        
        likeButton.layer.cornerRadius = 5
        likeButton.layer.masksToBounds = true
        
        commentButton.layer.cornerRadius = 5
        commentButton.layer.masksToBounds = true
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeClicked(_ sender: Any) {
        let likeObject = PFObject(className: "Likes")
        likeObject["from"] = PFUser.current()!.username!
        likeObject["to"] = postUUIDLabel.text!
        
        likeObject.saveInBackground { (success, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
            }else{
                print("saved")
                
//                ONESIGNAL ILE YAZILACAK FONKSIYONLAR
            }
        }
    }
    
    @IBAction func commentClicked(_ sender: Any) {
        
        let commentObject = PFObject(className: "Comments")
        commentObject["from"] = PFUser.current()!.username!
        commentObject["to"] = postUUIDLabel.text!
        
        commentObject.saveInBackground { (success, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
            }else{
                print("saved")
                
                //                ONESIGNAL ILE YAZILACAK FONKSIYONLAR
                
                
            }
        }
    }
}
