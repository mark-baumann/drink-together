//
//  AddExtraData.swift
//  DrinkTogether
//
//  Created by Mark Baumann on 14.03.21.
//

import UIKit
import Firebase
import FirebaseDatabase


var ref: DatabaseReference!

class AddExtraData: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    


    @IBOutlet var pickerView: UIPickerView!
    
    
    let data = ["male", "female", "else"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.dataSource = self
        pickerView.delegate = self
        
        
       

         
    }
    
    
   
    
    @IBAction func SafeButtonTapped(_ sender: Any) {
        
       
        
        let selectedYearPicker = data[pickerView.selectedRow(inComponent: 0)]
        print(selectedYearPicker)
    
           	
           
        let db = Firestore.firestore()
        
      
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "x")
                        .getDocuments { (querySnapshot, err) in
                            if err != nil {
                                print("Failed")
                                return
                            }

                            let  userdocid = querySnapshot!.documents[0].documentID
        
        
        
        
        
        db.collection("users").document(userdocid).setData([
            "gender": selectedYearPicker
        ],  merge: true ) 
        
        redirectHome()
           
    }
    
    func redirectHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabViewController) as! TabViewController
              
              
              
              view.window?.rootViewController = homeViewController
              view.window?.makeKeyAndVisible()
    }

}







}
