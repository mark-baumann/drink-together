//
//  SignUpViewController.swift
//  DrinkTogether
//
//  Created by Nikolas Obser on 02.12.20.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
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

    // Validate the sign up form and returns the error message if it failed
    func validateForm() -> String? {
        
        // No empty fields
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        return nil
    }
    
    func showError(message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate form
        let error = validateForm()
        if error != nil {
            // Show the error
            showError(message: error!)
            return
        }
        
        // Get cleaned form data
        let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Create the user
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            // Check for errors
            if err != nil {
                self.showError(message: "Error creating user")
                return
            }
            
            // User was created
            // Store the user data (username)
            let db = Firestore.firestore()
            
            db.collection("users").addDocument(data: ["username": username, "uid": result!.user.uid]) { (error) in
                if error != nil {
                    // broken user
                }
            }
            
            // Redirect to home screen
            self.redirectToNewHome()
        }
    }
    
    func redirectToNewHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as?HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
