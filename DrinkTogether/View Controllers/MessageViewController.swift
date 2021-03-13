//
//  MessageViewController.swift
//  DrinkTogether
//
//  Created by Mark Baumann on 13.03.21.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

class MessageViewController: UIViewController {

    let db = Firestore.firestore()
    
    
       
    
    
    
    
    @IBOutlet weak var MessageBox: UITextField!
    
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        
        TableView.delegate = self
        TableView.dataSource = self
        
        TableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    

 
    
    
    var messages: [Messsage] = [
    Messsage(sender: "mark@mark.de", body: "Hi"),
    Messsage(sender: "mark@mark.de", body: "Hi")
    ]
    
    
  
    @IBAction func sendMessage(_ sender: Any) {
        
        if let messageBody = MessageBox.text,
        
           let messageSender = Auth.auth().currentUser?.email {
            db.collection(FStore.collectionName).addDocument(data: [FStore.senderField: messageSender, FStore.bodyField: messageBody]) { (error) in
                if let e = error {
                    print("There was a issue saving data to Firestore" , e)
                }
            }
        }
        
        
        
    }
    
}


extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.Label.text = messages[indexPath.row].body
        return cell
        
    }
    
    
}


extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
