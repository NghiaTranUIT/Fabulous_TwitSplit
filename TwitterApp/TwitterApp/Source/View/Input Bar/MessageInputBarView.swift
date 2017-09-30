//
//  MessageInputBarView.swift
//  TwitterApp
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import UIKit

protocol MessageInputBarViewDelegate: class {

    func shouldSend(message: String)
}

class MessageInputBarView: UIView {

    // MARK: - OUTLET
    @IBOutlet fileprivate weak var textView: UITextView!
    @IBOutlet fileprivate weak var sentBtn: UIButton!

    // MARK: - Variable
    public weak var delegate: MessageInputBarViewDelegate?

    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()

        // Setup
        initCommon()
    }


    @objc func sendBtnTapped() {
        delegate?.shouldSend(message: textView.text)

        // Reset
        self.textView.text = ""
    }

}

// MARK: - Private
extension MessageInputBarView {

    fileprivate func initCommon() {
        textView.delegate = self
        sentBtn.addTarget(self, action: #selector(MessageInputBarView.sendBtnTapped), for: UIControlEvents.touchUpInside)
    }
}

// MARK: - Text View Delegate
extension MessageInputBarView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {

        if textView.text.characters.count == 0 {
            sentBtn.isEnabled = false
        } else {
            sentBtn.isEnabled = true
        }
    }
}

// MARK: - XIBInitialization
extension MessageInputBarView: XIBInitialization {
    typealias XIBType = MessageInputBarView
}
