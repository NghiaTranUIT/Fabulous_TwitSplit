//
//  TweetViewController.swift
//  TwitterApp
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import UIKit
import TwitterCore

class TweetViewController: UIViewController {

    // MARK: - Variable
    var viewModel: TwitterViewModelProtocol!
    fileprivate var dataSource: TweetDataSource!

    // MARK: - OUTLET
    fileprivate lazy var tableView: UITableView = self.lazyInitTableView()
    fileprivate lazy var messageInputView: MessageInputBarView = self.lazyInitInputBar()

    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initCommon()
        setupView()
        binding()
    }
}

// MARK: - Private
extension TweetViewController {

    fileprivate func binding() {

    }
}

extension TweetViewController {

    fileprivate func initCommon() {

    }

    fileprivate func setupView() {

        self.view.addSubview(tableView)
        self.view.addSubview(messageInputView)

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),
            tableView.leftAnchor.constraintEqualToSystemSpacingAfter(guide.leftAnchor, multiplier: 1.0),
            tableView.rightAnchor.constraintEqualToSystemSpacingAfter(guide.rightAnchor, multiplier: 1.0),
            tableView.bottomAnchor.constraintEqualToSystemSpacingBelow(messageInputView.topAnchor, multiplier: 1.0),
            messageInputView.leftAnchor.constraintEqualToSystemSpacingAfter(guide.leftAnchor, multiplier: 1.0),
            messageInputView.rightAnchor.constraintEqualToSystemSpacingAfter(guide.rightAnchor, multiplier: 1.0),
            messageInputView.bottomAnchor.constraintEqualToSystemSpacingBelow(guide.bottomAnchor, multiplier: 1.0)
            ])

    }

    fileprivate func lazyInitTableView() -> UITableView {

        // Data Source
        let dataSource = TweetDataSource(viewModel: viewModel)

        // Table View
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = dataSource
        table.delegate = dataSource
        table.estimatedRowHeight = UITableViewAutomaticDimension
        table.register(UINib(nibName: MessageViewCell.identifier, bundle: nil),
                       forCellReuseIdentifier: MessageViewCell.identifier)
        return table
    }

    fileprivate func lazyInitInputBar() -> MessageInputBarView {
        let input = MessageInputBarView.xib()
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }
}

// MARK: - XIBInitialization
extension TweetViewController: XIBInitialization {
    typealias XIBType = TweetViewController
}
