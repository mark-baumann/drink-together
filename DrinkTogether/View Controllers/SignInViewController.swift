//
//  SignInViewController.swift
//  DrinkTogether
//
//  Created by Nikolas Obser on 02.12.20.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        
        // Hide the error message dummy
        errorLabel.alpha = 0
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // Validate the sign in form and returns the error message if it failed
    func validateForm() -> String? {
        
        // No empty fields
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        return nil
    }
    
    func showError(message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        
        // Validate form
        let error = validateForm()
        if error != nil {
            // Show the error
            showError(message: error!)
            return
        }
        
        // Get cleaned form data
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Sign in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            // Check for errors
            if err != nil {
                self.showError(message: "Could not sign in.")
                return
            }
            
            self.redirectToNewHome()
        }
    }
    
    func redirectToNewHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as?HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
