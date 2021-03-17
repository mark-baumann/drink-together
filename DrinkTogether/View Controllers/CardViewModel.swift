//
//  CardViewModel.swift
//  tinder-clone
//
//  Created by Mark Baumann on 17.03.21.
//
import UIKit


struct CardViewModel{
     let user: User
    
    let infoText: NSAttributedString
    
    init(user: User) {
        self.user = user
        
        let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy), .foregroundColor: UIColor.white])
        
        attributedText.append(NSAttributedString(string:" \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 32), .foregroundColor: UIColor.white]))
        
        
        self.infoText = attributedText
    }
}
