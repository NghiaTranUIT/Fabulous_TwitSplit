//
//  MessageViewCell.swift
//  TwitterApp
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: - XIBInitialization
extension MessageViewCell: XIBInitialization {
    typealias XIBType = MessageViewCell
}
