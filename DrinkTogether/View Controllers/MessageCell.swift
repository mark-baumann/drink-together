//
//  MessageCell.swift
//  DrinkTogether
//
//  Created by Mark Baumann on 13.03.21.
//

import UIKit

class MessageCell: UITableViewCell {

    
    @IBOutlet weak var MessageBubble: UIView!
    
    
    @IBOutlet weak var Label: UILabel!
    
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MessageBubble.layer.cornerRadius = MessageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
