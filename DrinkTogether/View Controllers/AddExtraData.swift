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
        
        switch pickerView.tag {
        case 1:
            return data.count
        case 2:
            return dataKg.count
        default:
            return 1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return data[row]
        case 2:
            return dataKg[row]
        default:
            return "Data not found"
        }

    }
    
   
    

    

    @IBOutlet  var pickerView2: UIPickerView!
    
    
    @IBOutlet var pickerView: UIPickerView!
    
    
    let data = ["male", "female", "else"]
    let dataKg = ["40 kg", "40,5 kg", "41 kg", "41,5 kg", "42 kg", "42,5 kg", "43 kg", "43,5 kg", "44 kg", "44,5 kg", "45 kg", "45,5 kg", "46 kg", "46,5 kg", "47 kg", "47,5 kg", "48 kg", "48,5 kg", "49 kg", "49,5 kg", "50 kg", "50,5 kg", "51 kg", "51,5 kg", "52 kg", "52,5 kg", "53 kg", "53,5 kg", "54 kg", "54,5 kg", "55 kg", "55,5 kg", "56 kg", "56,5 kg", "57 kg", "57,5 kg", "58 kg", "58,5 kg", "59 kg", "59,5 kg", "60 kg", "60,5 kg", "61 kg", "61,5 kg", "62 kg", "62,5 kg", "63 kg", "63,5 kg", "70 kg", "70,5 kg", "71 kg", "71,5 kg", "72 kg", "72,5 kg", "73 kg", "73,5 kg", "74 kg", "74,5 kg", "75 kg", "75,5 kg", "76 kg", "76,5 kg", "77 kg", "77,5 kg", "78 kg", "78,5 kg", "79 kg",  "79,5 kg", "80 kg", "80,5 kg", "81 kg", "81,5 kg", "82 kg", "82,5 kg", "83 kg", "83,5 kg", "84 kg", "84,5 kg", "85 kg", "85,5 kg", "86 kg", "86,5 kg", "87 kg", "87,5 kg", "88 kg", "88,5 kg", "89 kg", "89,5 kg", "90 kg", "90,5 kg", "91 kg", "91,5 kg", "92 kg", "92,5 kg", "93 kg", "93,5 kg", "94 kg", "94,5 kg", "95 kg", "95,5 kg", "96 kg", "96,5 kg", "97 kg", "97,5 kg", "98 kg", "98,5 kg", "99 kg", "99,5 kg", "100 kg", "101 kg", "101,5 kg", "102 kg", "102,5 kg", "103 kg", "103,5 kg", "104 kg", "104,5 kg", "105 kg", "105,5 kg", "106 kg", "106,5 kg", "107 kg", "107,5 kg", "108 kg", "108,5 kg", "109 kg", "109,5 kg", "110 kg"]
        
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.dataSource = self
        pickerView.delegate = self
        
        
        pickerView2.dataSource = self
        pickerView2.delegate = self

         
        pickerView.tag = 1
        pickerView2.tag = 2
    }
    
    
   
    
    @IBAction func SafeButtonTapped(_ sender: Any) {
        
       
        
        let selectedYearPicker = data[pickerView.selectedRow(inComponent: 0)]
        
        
        let selectedWeight = dataKg[pickerView2.selectedRow(inComponent: 0)]
        
        print(selectedWeight)
    
           	
           
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
          db.collection("users").document(userdocid).setData([
                                "weight": selectedWeight
                            ],  merge: true )
        
        redirectHome()
           
    }
    
    func redirectHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) 
              
              
              
              view.window?.rootViewController = homeViewController
              view.window?.makeKeyAndVisible()
    }

}







}
