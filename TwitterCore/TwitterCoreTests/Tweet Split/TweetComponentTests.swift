//
//  TweetComponentTests.swift
//  TwitterCoreTests
//
//  Created by Nghia Tran on 9/29/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import XCTest
@testable import TwitterCore

class TweetComponentTests: XCTestCase {

    fileprivate let tweetConfiguration = TweetDefaultConfiguration.default

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBuildTweetObjFromAppropriateWords() {

        // Given
        let wordStacks = ["Hello", "It", "is", "the", "ordinary", "comment"]
        let expected = "1/2 Hello It is the ordinary comment"

        // When
        let indicator = FakeTweetIndicator(index: 1, total: 2)
        let component = TweetComponent(indicator:indicator,
                                       wordStacks: wordStacks)
        let tweetObj = component.build()

        // Then
        XCTAssert(tweetObj.text == expected, "TweetObj's text doesn't match with words which built from TweetComponent")
    }

    func testUpdateTotalPage() {

        // Given
        let indicator = FakeTweetIndicator(index: 1, total: 2)
        let expected = FakeTweetIndicator(index: 1, total: 5)

        // When
        let component = TweetComponent(indicator:indicator,
                                       wordStacks: [])
        component.updateTotalPage(expected.total)
        let tweet = component.build()

        // Then
        XCTAssert(tweet.text == expected.toString(), "Indicator page didn't update the total number")
    }

    func testAppendNewWordIntoStackWithoutExcessed() {

        // Given
        let wordStacks = ["Hello", "It", "is", "the", "ordinary", "comment"]

        // When
        let indicator = FakeTweetIndicator(index: 1, total: 2)
        let component = TweetComponent(indicator:indicator,
                                       wordStacks: wordStacks)
        let isExcess = component.append("SWIFT", maxCount: tweetConfiguration.maxTweetCharacterCount)

        // Then
        XCTAssertFalse(isExcess, "Append short word into non-full stack shouldn't be excessive")
    }

    func testAppendNewWordIntoStackCauseExcessed() {

        // Given
        let wordStacks = ["Hello", "It", "is", "the", "ordinary", "comment"]

        // When
        let indicator = FakeTweetIndicator(index: 1, total: 2)
        let component = TweetComponent(indicator:indicator,
                                       wordStacks: wordStacks)
        let isExcess = component.append("SWIFTSWIFTSWIFTSWIFTSWIFTSWIFTSWIFTSWIFTSWIFT",
                                        maxCount: tweetConfiguration.maxTweetCharacterCount)

        // Then
        XCTAssertTrue(isExcess, "Append too long word into non-full stack should be excessed")
    }
}
