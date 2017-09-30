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
    fileprivate var data: [MessageCellPresentable] = []

    public func append(_ newTweets: [MessageCellPresentable]) {
        data.append(contentsOf: newTweets)
    }
}

extension TweetDataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MessageViewCell.identifier, for: indexPath) as! MessageViewCell
        let item = data[indexPath.row]
        cell.updatePresentor(item)
        return cell
    }
}

extension TweetDataSource: UITableViewDelegate {

}
