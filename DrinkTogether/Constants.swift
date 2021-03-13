//
//  Constants.swift
//  DrinkTogether
//
//  Created by Nikolas Obser on 02.12.20.
//

import Foundation

struct Constants {
    struct Storyboard {
        static let homeViewController = "HomeVC"
        static let tabViewController = "Tab"
    }
}


struct K {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct BrandColors {
            static let purple = "BrandPurple"
            static let lightPurple = "BrandLightPurple"
            static let blue = "BrandBlue"
            static let lighBlue = "BrandLightBlue"
        }
    
}

struct FStore{
    static let collectionName = "messages"
    static let senderField = "sender"
    static let bodyField = "body"
    static let dateField = "date"
}
