//
//  MessageViewCell.swift
//  TwitterApp
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import UIKit
import TwitterCore

class MessageViewCell: UITableViewCell {

    // MARK: - OUTLET
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updatePresentor(_ presentor: MessageCellPresentable) {
        self.messageLbl.text = presentor.message
        self.userNameLbl.text = presentor.userName
    }
}

// MARK: - XIBInitialization
extension MessageViewCell: XIBInitialization {
    typealias XIBType = MessageViewCell
}
