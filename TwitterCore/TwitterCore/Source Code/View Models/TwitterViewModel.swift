//
//  TwitterViewModel.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

protocol TwitterViewModelProtocol {

    var input: TwitterViewModelInput { get }
    var output: TwitterViewModelOutput { get }
}
protocol TwitterViewModelInput {

}

protocol TwitterViewModelOutput {

}

class TwitterViewModel: TwitterViewModelProtocol, TwitterViewModelInput, TwitterViewModelOutput {

    // MARK: - View Model
    var input: TwitterViewModelInput { return self }
    var output: TwitterViewModelOutput { return self }

    // MARK: - Input

    // MARK: - Output

    // MARK: - Init
    init() {

    }
}
