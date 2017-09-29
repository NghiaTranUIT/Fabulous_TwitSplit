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
            assert(error == .wordLengthExcess, error.localizedDescription)
        case .success:
            assertionFailure("Wrong")
        }
    }

    func testCreateTweetComponentWithNewOneCase() {

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

    func testCreateTweetComponentCase() {

        // Give
        let input = "Facebook just switched several of its open source projects — including React — over to the popular MIT license. Before that, Facebook was using their own custom “BSD+Patents” license. This was similar to the widely-used BSD license, but also included a clause that basically said: “you can’t sue Facebook for infringing on your patents. This license came under fire this summer. Here’s what happened."

        let expected = ["1/9 Facebook just switched several of its open", "2/9 source projects — including React — over to", "3/9 the popular MIT license. Before that, Facebook", "4/9 was using their own custom “BSD+Patents”", "5/9 license. This was similar to the widely-used", "6/9 BSD license, but also included a clause that", "7/9 basically said: “you can’t sue Facebook for", "8/9 infringing on your patents. This license came", "9/9 under fire this summer. Here’s what happened."]

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

    func testOneWordIsExcessMaximumCase() {

        // Give
        let input = "Facebook just switched several of its open source projects — including ReactReactReactReactReactReactReactReactReactReactReactReactReactReactReact — over to the popular MIT license. Before that, Facebook was using their own custom “BSD+Patents” license. This was similar to the widely-used BSD license, but also included a clause that basically said: “you can’t sue Facebook for infringing on your patents. This license came under fire this summer. Here’s what happened."

        // When
        let processor = TweetSplitProcessor()
        let result = processor.process(input)

        // Then
        switch result {
        case .error(let error):
            assert(error == .wordLengthExcess, error.localizedDescription)
        case .success:
            assertionFailure("Wrong")
        }
    }
}
