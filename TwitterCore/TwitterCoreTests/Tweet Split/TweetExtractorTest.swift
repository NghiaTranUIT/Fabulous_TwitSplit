//
//  TweetExtractorTest.swift
//  TwitterCoreTests
//
//  Created by Nghia Tran on 9/29/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import XCTest
@testable import TwitterCore

class TweetExtractorTest: XCTestCase {

    fileprivate let tweetConfiguration = TweetDefaultConfiguration.default

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExtractorByWhiteSpace() {

        // Given
        let message = "😉 there are thousands of topics and sub-topics. Most of these are Wikipedia-style stubs with nothing more than a name. You can do some research and help flesh-out these stubs."
        let expected = ["😉", "there", "are", "thousands", "of", "topics", "and", "sub-topics.", "Most", "of", "these", "are", "Wikipedia-style" ,"stubs", "with", "nothing", "more", "than", "a", "name.", "You", "can", "do", "some", "research", "and", "help", "flesh-out", "these", "stubs."]

        // When
        let extractor = TweetExtractor(configurable: tweetConfiguration)

        // Then
        let result = extractor.extract(message)
        XCTAssert(result == expected, "TweetExtractor should split whole mssage to individual words by white-space")
    }

}
