//
//  MessageViewController.swift
//  DrinkTogether
//
//  Created by Mark Baumann on 13.03.21.
//

import UIKit

class MessageViewController: UIViewController {

    
    
    @IBOutlet weak var MessageBox: UITextField!
    
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        TableView.dataSource = self
        
        
    }
    

   
    
    
    
    
    var messages: [Messsage] = [
    Messsage(sender: "mark@mark.de", body: "Hi"),
    Messsage(sender: "mark@mark.de", body: "Hi")
    ]
    
    
    
    
}


extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = messages[indexPath.row].body
        return cell
        
    }
    
    
}
