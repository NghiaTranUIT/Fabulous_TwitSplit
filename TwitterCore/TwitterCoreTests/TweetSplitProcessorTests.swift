//
//  TweetSplitProcessorTests.swift
//  TwitterCoreTests
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import XCTest
@testable import TwitterCore

extension Array where Element == TweetObj {

    func mapToString() -> [String] {
        return self.map{ (i) -> String in
            return i.text
        }
    }
}

class TweetSplitProcessorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTweetMessageLengthLessThanMaximum() {

        // Give
        let input = "Hello, Swift"
        let expected = ["Hello, Swift"]

        // When
        let processor = TweetSplitProcessor()
        let result = processor.process(input)

        // Then
        switch result {
        case .error(let error):
            assertionFailure(error.localizedDescription)
        case .success(let tweets):
            print(tweets)
            assert(expected == tweets.mapToString(), "OK")
        }
    }

    func testAnyMessageLengthExcessThanMaximum() {

        // Give
        let input = "Hello, Swiftabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabc"

        // When
        let processor = TweetSplitProcessor()
        let result = processor.process(input)

        // Then
        switch result {
        case .error(let error):
            assert(error == .invalid, error.localizedDescription)
        case .success:
            assertionFailure("Wrong")
        }
    }

    func testNormalCase() {

        // Give
        let input = "Twitter mostly uses Ruby on Rails for their front-end and primarily Scala and Java for back-end services. They use Apache Thrift (originally developed by Facebook) to communicate between different internal services."

        let expected = ["1/6 Twitter mostly uses Ruby on Rails for their", "2/6 front-end and primarily Scala and Java for", "3/6 back-end services. They use Apache Thrift", "4/6 (originally developed by Facebook) to", "5/6 communicate between different internal", "6/6 services."]

        // When
        let processor = TweetSplitProcessor()
        let result = processor.process(input)

        // Then
        switch result {
        case .error(let error):
            assertionFailure(error.localizedDescription)
        case .success(let tweets):
            print(tweets.mapToString())
            assert(expected == tweets.mapToString(), "OK")
        }
    }
}
