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

    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    /// Update new data from presentor
    ///
    /// - Parameter presentor: MessageCellPresentable's instance which represent the real data we need to show on UI
    func updatePresentor(_ presentor: MessageCellPresentable) {

        //
        // By using MessageCellPresentable protocol
        // It's obviously to realize the benefits
        //
        // In the future, if we change the core model (Ex. TweetObj or MessageObj)
        // we don't need to go back here and change the code again
        //
        //
        // [Bad Practice]: Heavily reply on concrete model classes
        // self.messageLbl.text = messageObj.message
        // self.userNameLbl.text = messageObj.userObj.username
        //
        //
        // [Good Practice]
        // Here
        self.messageLbl.text = presentor.message
        self.userNameLbl.text = presentor.userName
    }
}

// MARK: - XIBInitialization
extension MessageViewCell: XIBInitialization {
    typealias XIBType = MessageViewCell
}
