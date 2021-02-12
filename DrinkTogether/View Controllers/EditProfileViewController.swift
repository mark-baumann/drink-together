//
//  ProfileViewController.swift
//  DrinkTogether
//
//  Created by Mark Baumann   on 23.12.20.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseCore

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    
    let storage = Storage.storage().reference()
    
   
    
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
    
   
    
    
    @IBAction func UploadImage(_ sender: Any) {
        
        
        let picker = UIImagePickerController()
        
        picker.sourceType = .photoLibrary
        
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }
        
    
        
            storage.child("images/file.png").putData(imageData, metadata: nil, completion: { _, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            
            
            
            
        })
        
        
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
