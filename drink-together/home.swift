//
//  home.swift
//  drink-together
//
//  Created by Mark Baumann on 08.05.20.
//  Copyright © 2020 Mark Baumann. All rights reserved.
//

import UIKit

class home: UIViewController {

    
    
    @IBOutlet weak var leading: NSLayoutConstraint!
    
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    var menuout = false
    
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTapped(false)
        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func menuTapped(_ sender: Any) {
        
        if menuout == false {
            leading.constant = 150
            trailing.constant = -150
            menuout = true
            button.isHidden = false
        }else {
            leading.constant = 0
            trailing.constant = 0
            menuout = false
            button.isHidden = true
        }
    }
    
}
