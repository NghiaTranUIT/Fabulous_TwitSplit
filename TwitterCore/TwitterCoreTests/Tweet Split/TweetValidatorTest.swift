//
//  TweetValidatorTest.swift
//  TwitterCoreTests
//
//  Created by Nghia Tran on 9/29/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import XCTest
@testable import TwitterCore

class TweetValidatorTest: XCTestCase {

    fileprivate let tweetConfiguration = TweetDefaultConfiguration.default

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyMessage() {

        // Given
        let message = ""

        // When
        let validator = TweetValidator()

        // Then
        let error = validator.validateEmptyMessage(message)
        XCTAssertNotNil(error, "Empty Message is invalid")
        XCTAssert(error! == .invalid, "Validate Result should be invalid")
    }

    func testMessageContainsOneWordExcessMaximum() {

        // Given
        let message = "Hello Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift,Swift"
        let words = message.components(separatedBy: tweetConfiguration.characterSet)

        // When
        let validator = TweetValidator()

        // Then
        let error = validator.validateWordExcessMaximumCount(words,
                                                             max: tweetConfiguration.maxTweetCharacterCount)
        XCTAssertNotNil(error, "Empty Message is invalid")
        XCTAssert(error! == .wordLengthExcess, "Validate Result should be invalid")
    }

}
