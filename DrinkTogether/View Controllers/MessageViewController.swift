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
    
    
       
    var messages: [Message] = []
    
    
    
    @IBOutlet weak var MessageBox: UITextField!
    
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        
        TableView.dataSource = self
        
        TableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    

    func loadMessages() {
        
        db.collection(FStore.collectionName)
                   .order(by: FStore.dateField)
                   .addSnapshotListener { (querySnapshot, error) in
                   
                   self.messages = []
                   
                   if let e = error {
                       print("There was an issue retrieving data from Firestore. \(e)")
                   } else {
                       if let snapshotDocuments = querySnapshot?.documents {
                           for doc in snapshotDocuments {
                               let data = doc.data()
                               if let messageSender = data[FStore.senderField] as? String, let messageBody = data[FStore.bodyField] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                   self.messages.append(newMessage)
                                   
                                   DispatchQueue.main.async {
                                          self.TableView.reloadData()
                                       let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                       self.TableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                   }
                               }
                           }
                       }
                   }
               }
       
        
        
        
    }
    
    
    
    
    
  
    @IBAction func sendMessage(_ sender: Any) {
        
        if let messageBody = MessageBox.text, let messageSender = Auth.auth().currentUser?.email {
                   db.collection(FStore.collectionName).addDocument(data: [
                       FStore.senderField: messageSender,
                       FStore.bodyField: messageBody,
                       FStore.dateField: Date().timeIntervalSince1970
                   ]) { (error) in
                       if let e = error {
                           print("There was an issue saving data to firestore, \(e)")
                       } else {
                           print("Successfully saved data.")
                           
                           DispatchQueue.main.async {
                                self.MessageBox.text = ""
                           }
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
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.Label.text = messages[indexPath.row].body
        
        if message.sender == Auth.auth().currentUser?.email {
                 
            //This is a message from the current user.
                   cell.MessageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
                   cell.Label.textColor = UIColor(named: K.BrandColors.purple)
               }
               //This is a message from another sender.
               else {
                   
                   cell.MessageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
                   cell.Label.textColor = UIColor(named: K.BrandColors.lightPurple)
               }
    
        
        return cell
        
    }
    
    
}


extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

