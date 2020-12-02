//
//  HomeViewController.swift
//  DrinkTogether
//
//  Created by Nikolas Obser on 02.12.20.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
  
        // TEST
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "x")
            .getDocuments { (querySnapshot, err) in
                if err != nil {
                    self.testLabel.text = "Failed to fetch the username"
                    return
                }
                
                let userData = querySnapshot!.documents[0].data()
                self.testLabel.text = userData["username"] as? String
            }
        // TEST END
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
