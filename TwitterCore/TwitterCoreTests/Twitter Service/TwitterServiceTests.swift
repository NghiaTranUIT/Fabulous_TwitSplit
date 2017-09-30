//
//  TwitterServiceTests.swift
//  TwitterCoreTests
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import XCTest
@testable import TwitterCore

struct StubTweetSplitProcessor: SplitProcessor {

    var configuration: TweetConfigurable { return TweetDefaultConfiguration() }
    var indicator: TweetIndicatorProtocol { return StubTweetIndicator() }
    var extractor: TweetExtractorProtocol { return StubTweetExtractor() }
    var validator: TweetValidatorProtocol { return StubTweetValidator() }

    func process(_ message: String) -> SplitResult {
        let tweetObj = TweetObj(text: message)
        return .success([tweetObj])
    }
}

class TwitterServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTwitterServiceWithNormalMessage() {

        // Given
        let input = "Hello, Swift"
        let stubProcessor = StubTweetSplitProcessor()
        let service = TwitterService(splitProcessor: stubProcessor)
        let expected = ["Hello, Swift"]

        // When
        let result = service.splitMessage(input)

        // Then
        XCTAssertTrue(result.isSucces, "Twitter Service should be successfull")
        XCTAssertEqual(result.rawValue.mapToString(), expected, "")
    }
}
