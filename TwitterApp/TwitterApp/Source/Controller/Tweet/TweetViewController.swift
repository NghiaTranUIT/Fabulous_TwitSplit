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

        // Update Tweets
        viewModel.output
            .tweetsDriver
            .drive(onNext: {[weak self] (result) in
                guard let `self` = self else { return }

                switch result {
                case .error(let error):

                    // Error
                    self.handleError(error)

                case .success(let tweets):

                    // Append & reload
                    self.dataSource.append(tweets)
                    self.tableView.reloadData()
                }
            })
            .addDisposableTo(disposeBag)
    }


    /// Handle all error here
    /// Take a adventage from ValidateError enum, so we can use Switch easily
    ///
    /// - Parameter error: ValidateError's instance
    fileprivate func handleError(_ error: ValidateError) {
        print(error)
    }
}

extension TweetViewController {

    fileprivate func initCommon() {
        view.layoutMargins = UIEdgeInsets.zero
    }

    fileprivate func setupView() {

        self.view.addSubview(tableView)
        self.view.addSubview(messageInputView)

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor),
            messageInputView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            messageInputView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            messageInputView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
            ])

    }

    fileprivate func lazyInitTableView() -> UITableView {

        // Table View
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = dataSource
        table.delegate = dataSource
        table.insetsContentViewsToSafeArea = false
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 44
        table.preservesSuperviewLayoutMargins = true
        table.tableFooterView = UIView()
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
