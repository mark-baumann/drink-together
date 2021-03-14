//
//  ProfileViewController.swift
//  DrinkTogether
//
//  Created by Mark Baumann on 12.02.21.
//

import UIKit
import FirebaseStorage
import FirebaseCore
import FirebaseDatabase
import SDWebImage
import FirebaseUI

class ProfileViewController: UIViewController {

    let db = Firestore.firestore()
    
    
    @IBOutlet weak var NameLabel: UILabel!
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUsername()
       
            downloadImages()
            
    
        
        
    }
    
   
    func getUsername() {
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "x")
             .getDocuments { (querySnapshot, err) in


                 let username = querySnapshot!.documents[0].get("username")
                self.NameLabel.text = username as! String
             
         }
       
    }
    
    
    
    func downloadImages() {
        
        
        if Auth.auth() != nil {
            let storageRef = Storage.storage().reference()
            
            
            
            
            // Reference to an image file in Firebase Storage
            let reference = storageRef.child("images/"+Auth.auth().currentUser!.uid+".png")

            // UIImageView in your ViewController
            let imageView: UIImageView = self.imageView

            // Placeholder image
            let placeholderImage = UIImage(named: "placeholder.jpg")

            // Load the image using SDWebImage
            imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
                
                
           
        }
        }
        
        
        
    
   
    
    
    
    

}
