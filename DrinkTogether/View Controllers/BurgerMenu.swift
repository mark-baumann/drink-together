//
//  BurgerMenu.swift
//  DrinkTogether
//
//  Created by Mark Baumann   on 04.12.20.
//

import UIKit
import SideMenu

class BurgerMenu: UIViewController {

    var menu:SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        
        menu = SideMenuNavigationController(rootViewController: menuListController())
        // Do any additional setup after loading the view.
        menu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = menu
        
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)
        
        
    }
    
    @IBAction func didTap() {
        present(menu!, animated: true)
    }
    

}


class menuListController: UITableViewController {
    
    var items = ["first", "second", "third"]
    
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    

    
}
