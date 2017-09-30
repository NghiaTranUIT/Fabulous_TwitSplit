//
//  TweetViewController.swift
//  TwitterApp
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import UIKit
import TwitterCore
import RxCocoa
import RxSwift

class TweetViewController: UIViewController {

    // MARK: - Variable
    var viewModel: TwitterViewModelProtocol!

    fileprivate let dataSource = TweetDataSource()
    fileprivate let disposeBag = DisposeBag()

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

        viewModel.output.tweetsDriver
            .drive(onNext: {[weak self] (result) in
                guard let `self` = self else { return }

                switch result {
                case .error(let error):
                    print(error)
                case .success(let tweets):
                    self.dataSource.append(tweets)
                    self.tableView.reloadData()
                }
            })
        .addDisposableTo(disposeBag)

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

        // Table View
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = dataSource
        table.delegate = dataSource
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 44
        table.register(UINib(nibName: MessageViewCell.identifier, bundle: nil),
                       forCellReuseIdentifier: MessageViewCell.identifier)
        return table
    }

    fileprivate func lazyInitInputBar() -> MessageInputBarView {
        let input = MessageInputBarView.xib()
        input.delegate = self
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }
}

// MARK: - MessageInputBarViewDelegate
extension TweetViewController: MessageInputBarViewDelegate {

    func shouldSend(message: String) {
        viewModel.input.sendMessagePublish.onNext(message)
    }
}

// MARK: - XIBInitialization
extension TweetViewController: XIBInitialization {
    typealias XIBType = TweetViewController
}
