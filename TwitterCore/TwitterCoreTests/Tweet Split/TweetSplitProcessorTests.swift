//
//  TweetSplitProcessorTests.swift
//  TwitterCoreTests
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import XCTest
@testable import TwitterCore

class TweetSplitProcessorTests: XCTestCase {

    fileprivate let tweetConfiguration = TweetDefaultConfiguration.default

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
            XCTFail(error.localizedDescription)
        case .success(let tweets):
            let tweets = tweets.mapToString()
            XCTAssertTrue(tweets.isExcess(tweetConfiguration.maxTweetCharacterCount), "There is no Tweet which length is excessed the maximum")
            XCTAssertEqual(tweets.count, 1, "Should only 1 components")
            XCTAssertEqual(tweets, expected, "Short Message should be same the original")
        }
    }

    func testTheExampleInAssigment() {

        // Give
        let input = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expected = ["1/2 I can't believe Tweeter now supports chunking",
                        "2/2 my messages, so I don't have to do it myself."]

        // When
        let processor = TweetSplitProcessor()
        let result = processor.process(input)

        // Then
        switch result {
        case .error(let error):
            XCTFail(error.localizedDescription)
        case .success(let tweets):
            let tweets = tweets.mapToString()
            XCTAssertTrue(tweets.isExcess(tweetConfiguration.maxTweetCharacterCount), "There is no Tweet which length is excessed the maximum")
            XCTAssertEqual(tweets.count, 2, "Should only 2 components")
            XCTAssertEqual(tweets, expected, "Same the expectation from the Assignment")
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
            XCTAssertEqual(error, .wordLengthExcess, error.localizedDescription)
        case .success:
            XCTFail("the Legnth of certain words are over the maximum.")
        }
    }

    func testCreateTweetComponentWithNewOneCase() {

        // Give
        let input = "Twitter mostly uses Ruby on Rails for their front-end and primarily Scala and Java for back-end services. They use Apache Thrift (originally developed by Facebook) to communicate between different internal services."

        let expected = ["1/6 Twitter mostly uses Ruby on Rails for their",
                        "2/6 front-end and primarily Scala and Java for",
                        "3/6 back-end services. They use Apache Thrift",
                        "4/6 (originally developed by Facebook) to",
                        "5/6 communicate between different internal",
                        "6/6 services."]

        // When
        let processor = TweetSplitProcessor()
        let result = processor.process(input)

        // Then
        switch result {
        case .error(let error):
            assertionFailure(error.localizedDescription)
        case .success(let tweets):
            let tweets = tweets.mapToString()
            XCTAssertTrue(tweets.isExcess(tweetConfiguration.maxTweetCharacterCount), "There is no Tweet which length is excessed the maximum")
            XCTAssertEqual(tweets, expected, "The last character (Service) didn't add to new component")
        }
    }

    func testSplitTweetToMoreThanOneTweet() {

        // Give
        let input = "Facebook just switched several of its open source projects — including React — over to the popular MIT license. Before that, Facebook was using their own custom “BSD+Patents” license. This was similar to the widely-used BSD license, but also included a clause that basically said: “you can’t sue Facebook for infringing on your patents. This license came under fire this summer. Here’s what happened."

        let expected = ["1/9 Facebook just switched several of its open",
                        "2/9 source projects — including React — over to",
                        "3/9 the popular MIT license. Before that, Facebook",
                        "4/9 was using their own custom “BSD+Patents”",
                        "5/9 license. This was similar to the widely-used",
                        "6/9 BSD license, but also included a clause that",
                        "7/9 basically said: “you can’t sue Facebook for",
                        "8/9 infringing on your patents. This license came",
                        "9/9 under fire this summer. Here’s what happened."]

        // When
        let processor = TweetSplitProcessor()
        let result = processor.process(input)

        // Then
        switch result {
        case .error(let error):
            XCTFail(error.localizedDescription)
        case .success(let tweets):
            let tweets = tweets.mapToString()
            XCTAssertTrue(tweets.isExcess(tweetConfiguration.maxTweetCharacterCount), "There is no Tweet which length is excessed the maximum")
            XCTAssertEqual(expected, tweets, "Split Tweet into more than one Tweet")
        }
    }

    func testOneWordIsExcessMaximumCase() {

        // Give
        let input = "Facebook just switched several of its open source projects — including ReactReactReactReactReactReactReactReactReactReactReactReactReactReactReact — over to the popular MIT license. Before that, Facebook was using their own custom “BSD+Patents” license. This was similar to the widely-used BSD license, but also included a clause that basically said: “you can’t sue Facebook for infringing on your patents. This license came under fire this summer. Here’s what happened."

        // When
        let processor = TweetSplitProcessor()
        let result = processor.process(input)

        // Then
        switch result {
        case .error(let error):
            XCTAssertEqual(error, .wordLengthExcess, error.localizedDescription)
        case .success:
            XCTFail("the Legnth of certain words are over the maximum.")
        }
    }

    func testTweetSplitProcessorShouldReplyOnCustomIndicatorExtractor() {

        // Give
        let input = "Facebook_just_switched_several_of_its_open_source_projects—including_React_over_to_the_popular_MIT_license._Before_that,_Facebook_was_using_their_own_custom_“BSD+Patents”_license._This_was_similar_to_the_widely-used_BSD_license,_but_also_included_a_clause_that_basically_said:_“you_can’t_sue_Facebook_for_infringing_on_your_patents._This_license_came_under_fire_this_summer._Here’s_what_happened."

        let expected = ["[1:10] Facebook just switched several of its open",
                        "[2:10] source projects—including React over to the",
                        "[3:10] popular MIT license. Before that, Facebook",
                        "[4:10] was using their own custom “BSD+Patents”",
                        "[5:10] license. This was similar to the",
                        "[6:10] widely-used BSD license, but also included",
                        "[7:10] a clause that basically said: “you can’t",
                        "[8:10] sue Facebook for infringing on your",
                        "[9:10] patents. This license came under fire this",
                        "[10:10] summer. Here’s what happened."]

        // When
        let squareIndicator = SquareTweetIndicator(index: 1, total: 1)
        let extractor = UnderlineTweetExtractor()
        let validator = StubTweetValidator()
        let processor = TweetSplitProcessor(indicator: squareIndicator,
                                            extractor: extractor,
                                            validator: validator,
                                            configuration: tweetConfiguration)
        let result = processor.process(input)

        // Then
        switch result {
        case .error(let error):
            XCTFail(error.localizedDescription)
        case .success(let tweets):
            let tweets = tweets.mapToString()
            XCTAssertTrue(tweets.isExcess(tweetConfiguration.maxTweetCharacterCount), "There is no Tweet which length is excessed the maximum")
            XCTAssertEqual(expected, tweets, "SplitProcessor didn't reply on custom indicator and extractor")
        }
    }
}
