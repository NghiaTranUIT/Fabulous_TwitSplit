//
//  TweetBuilderTest.swift
//  TwitterCoreTests
//
//  Created by Nghia Tran on 9/29/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import XCTest
@testable import TwitterCore

class TweetBuilderTest: XCTestCase {

    fileprivate let tweetConfiguration = TweetDefaultConfiguration.default

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTweetBuilderWithLongMessage() {
        let input = "Linearity is the property of a mathematical relationship or function which means that it can be graphically represented as a straight line. Examples are the relationship of voltage and current across a resistor, or the mass and weight of an object."

        let words = FakeTweetExtractor().extract(input)
        let expected = ["1/6 Linearity is the property of a mathematical",
                        "2/6 relationship or function which means that it",
                        "3/6 can be graphically represented as a straight",
                        "4/6 line. Examples are the relationship of voltage",
                        "5/6 and current across a resistor, or the mass and",
                        "6/6 weight of an object."]

        // When
        let indicator = FakeTweetIndicator(index: 1, total: 1)
        let builder = TweetBuilder(words: words, indicator: indicator, configuration: tweetConfiguration)
        let result = builder.build()
        let tweets = result.rawValue.mapToString()

        // Then
        XCTAssertTrue(result.isSucces, "Should process successfully")
        XCTAssertTrue(tweets.isExcess(tweetConfiguration.maxTweetCharacterCount), "There is no Tweet which length is excessed the maximum")
        XCTAssertEqual(tweets, expected, "TweetComponents didn't match with original message")
    }

    func testTweetWithSameIndicatorFormat() {
        let input = "Apart from counting words and characters, our online editor can help you to improve word choice and writing style, and, optionally, help you to detect grammar mistakes and plagiarism. To check word count, simply place your cursor into the text box above and start typing."

        let words = FakeTweetExtractor().extract(input)
        let expected = ["1/7 Apart from counting words and characters, our",
                        "2/7 online editor can help you to improve word",
                        "3/7 choice and writing style, and, optionally,",
                        "4/7 help you to detect grammar mistakes and",
                        "5/7 plagiarism. To check word count, simply place",
                        "6/7 your cursor into the text box above and start",
                        "7/7 typing."]

        // When
        let indicator = FakeTweetIndicator(index: 1, total: 1)
        let builder = TweetBuilder(words: words, indicator: indicator, configuration: tweetConfiguration)
        let result = builder.build()
        let tweets = result.rawValue.mapToString()
        print(tweets)

        // Then
        XCTAssertTrue(result.isSucces, "Should process successfully")
        XCTAssertTrue(tweets.isExcess(tweetConfiguration.maxTweetCharacterCount), "There is no Tweet which length is excessed the maximum")
        XCTAssertEqual(tweets, expected, "TweetComponents didn't match with original message")
    }

    func testToughtScenarioWhenTheTotalPageOfIndicatorIncreaseTheLengthOfTweet() {
        let input = "Apart from counting words and characters, our online editor can help you to improve word choice and writing style, and, optionally, help you to detect grammar mistakes and plagiarism. To check word count, simply place your cursor into the text box above and start typing. You'll see the number of characters and words increase or decrease as you type, delete, and edit them. You can also copy and paste text from another program over into the online editor above. The Auto-Save feature will make sure you won't lose any changes while editing, even if you leave the site and come back later. Tip: Bookmark this page now."

        let words = FakeTweetExtractor().extract(input)
        let expected = ["1/15 Apart from counting words and characters, our",
                        "2/15 online editor can help you to improve word",
                        "3/15 choice and writing style, and, optionally,",
                        "4/15 help you to detect grammar mistakes and",
                        "5/15 plagiarism. To check word count, simply place",
                        "6/15 your cursor into the text box above and start",
                        "7/15 typing. You\'ll see the number of characters",
                        "8/15 and words increase or decrease as you type,",
                        "9/15 delete, and edit them. You can also copy and",
                        "10/15 paste text from another program over into",
                        "11/15 the online editor above. The Auto-Save",
                        "12/15 feature will make sure you won\'t lose any",
                        "13/15 changes while editing, even if you leave the",
                        "14/15 site and come back later. Tip: Bookmark this",
                        "15/15 page now."]

        // When
        let indicator = FakeTweetIndicator(index: 1, total: 1)
        let builder = TweetBuilder(words: words, indicator: indicator, configuration: tweetConfiguration)
        let result = builder.build()
        let tweets = result.rawValue.mapToString()

        // Then
        XCTAssertTrue(result.isSucces, "Should process successfully")
        XCTAssertTrue(tweets.isExcess(tweetConfiguration.maxTweetCharacterCount), "There is no Tweet which length is excessed the maximum")
        XCTAssertEqual(tweets, expected, "TweetComponents didn't match with original message")
    }

    func testIndicatorSameFormatWithCustomTweetIndicator() {
        let input = "Linearity is the property of a mathematical relationship or function which means that it can be graphically represented as a straight line. Examples are the relationship of voltage and current across a resistor, or the mass and weight of an object."

        let words = FakeTweetExtractor().extract(input)
        let expected = ["[1:6] Linearity is the property of a mathematical",
                        "[2:6] relationship or function which means that it",
                        "[3:6] can be graphically represented as a straight",
                        "[4:6] line. Examples are the relationship of",
                        "[5:6] voltage and current across a resistor, or",
                        "[6:6] the mass and weight of an object."]

        // When
        let indicator = SquareTweetIndicator(index: 1, total: 1)
        let builder = TweetBuilder(words: words, indicator: indicator, configuration: tweetConfiguration)
        let result = builder.build()
        let tweets = result.rawValue.mapToString()

        // Then
        XCTAssertTrue(result.isSucces, "Should process successfully")
        XCTAssertTrue(tweets.isExcess(tweetConfiguration.maxTweetCharacterCount), "There is no Tweet which length is excessed the maximum")
        XCTAssertEqual(tweets, expected, "TweetComponents didn't match with original message")
    }


}
