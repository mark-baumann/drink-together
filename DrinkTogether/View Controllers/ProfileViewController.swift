//
//  ProfileViewController.swift
//  DrinkTogether
//
//  Created by Mark Baumann   on 23.12.20.
//

import UIKit
import Firebase


class ProfileViewController: UIViewController {

    
    
   
    
   
    
    @IBOutlet weak var changeUsername: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    
   
    }
    
    
    @IBAction func safeSettings(_ sender: Any?) {
    SaveInfo()
    }
    
    func SaveInfo() {
        let db = Firestore.firestore()
        
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "x")
            .getDocuments { (querySnapshot, err) in
                if err != nil {
                    print("Failed")
                    return
                }

                let  userdocid = querySnapshot!.documents[0].documentID
        
     
        
               
                    db.collection("users").document(userdocid).updateData(["username": self.changeUsername.text!])
        }
    
    
}
}
