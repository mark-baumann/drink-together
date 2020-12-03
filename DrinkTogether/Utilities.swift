//
//  Utilities.swift
//  DrinkTogether
//
//  Created by Nikolas Obser on 03.12.20.
//

import Foundation

class Utilities {
    static func isValidEmail(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: email)
    }
    
    static func isSecurePassword(password: String) -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$"
        return NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: password)
    }
}
