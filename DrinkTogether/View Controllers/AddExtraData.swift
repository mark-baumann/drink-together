//
//  AddExtraData.swift
//  DrinkTogether
//
//  Created by Mark Baumann on 14.03.21.
//

import UIKit

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
    

    

}






