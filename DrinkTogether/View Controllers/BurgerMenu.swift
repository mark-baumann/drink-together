//
//  BurgerMenu.swift
//  DrinkTogether
//
//  Created by Mark Baumann   on 08.12.20.
//

import UIKit

class BurgerMenu: UIViewController {

    
    @IBOutlet weak var leadingCon: NSLayoutConstraint!
    
    @IBOutlet weak var TrailingCon: NSLayoutConstraint!
    
    
    var menuOut = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func BurgerMenuTapped(_ sender: Any) {
        
        
        if (menuOut == false) {
            leadingCon.constant = 150
            TrailingCon.constant = -150
            menuOut = true
        }else {
            leadingCon.constant = 0
            TrailingCon.constant = 0
            menuOut = false
        }
        
        
    }
    
    
    

}
