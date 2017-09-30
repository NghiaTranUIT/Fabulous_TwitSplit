//
//  TweetDataSource.swift
//  TwitterApp
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation
import TwitterCore
import UIKit

class TweetDataSource: NSObject {

    // MARK: - Variable
    fileprivate let viewModel: TwitterViewModelProtocol

    // MARK: - Init
    init(viewModel: TwitterViewModelProtocol) {
        self.viewModel = viewModel
    }
}

extension TweetDataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension TweetDataSource: UITableViewDelegate {

}
