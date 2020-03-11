//
//  MyEssentialFeedAPIEndToEndTests.swift
//  MyEssentialFeedAPIEndToEndTests
//
//  Created by Dim on 20.01.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import XCTest
import MyEssentialFeed

class MyEssentialFeedAPIEndToEndTests: XCTestCase {

    func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {
        getFeedResult { result in
            switch result {
            case .success(let feed):
                XCTAssertEqual(feed.count, 8, "Expected 8 images in the test account feed")
                XCTAssertEqual(feed[0], self.expectedImage(at: 0))
                XCTAssertEqual(feed[1], self.expectedImage(at: 1))
                XCTAssertEqual(feed[2], self.expectedImage(at: 2))
                XCTAssertEqual(feed[3], self.expectedImage(at: 3))
                XCTAssertEqual(feed[4], self.expectedImage(at: 4))
                XCTAssertEqual(feed[5], self.expectedImage(at: 5))
                XCTAssertEqual(feed[6], self.expectedImage(at: 6))
                XCTAssertEqual(feed[7], self.expectedImage(at: 7))
            case .failure(let error):
                XCTFail("Expected successful feed result, got \(error) instead")
            }
        }
    }

    private func getFeedResult(
        file: StaticString = #file,
        line: UInt = #line,
        completion: @escaping (LoadFeedResult) -> Void
    ) {
        let testServerURL = URL(string: "https://essentialdeveloper.com/feed-case-study/test-api/feed")!
        let session = URLSession(configuration: .ephemeral)
        let client = URLSessionHTTPClient(session: session)
        let loader = RemoteFeedLoader(client: client, url: testServerURL)

        trackForMemoryLeaks(client, file: file, line: line)
        trackForMemoryLeaks(loader, file: file, line: line)

        let exp = expectation(description: "Wait for load completion")

        loader.load { result in
            completion(result)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 5.0)
    }

    private func expectedImage(at index: Int) -> FeedImage {
        return FeedImage(
            id: id(at: index),
            description: description(at: index),
            location: location(at: index),
            url: url(at: index)
        )
    }

    private func id(at index: Int) -> UUID {
        return UUID(
            uuidString: [
                "73A7F70C-75DA-4C2E-B5A3-EED40DC53AA6",
                "BA298A85-6275-48D3-8315-9C8F7C1CD109",
                "5A0D45B3-8E26-4385-8C5D-213E160A5E3C",
                "FF0ECFE2-2879-403F-8DBE-A83B4010B340",
                "DC97EF5E-2CC9-4905-A8AD-3C351C311001",
                "557D87F1-25D3-4D77-82E9-364B2ED9CB30",
                "A83284EF-C2DF-415D-AB73-2A9B8B04950B",
                "F79BD7F8-063F-46E2-8147-A67635C3BB01"
                ][index]
            )!
    }

    private func description(at index: Int) -> String? {
         return [
             "Description 1",
             nil,
             "Description 3",
             nil,
             "Description 5",
             "Description 6",
             "Description 7",
             "Description 8"
         ][index]
     }

      private func location(at index: Int) -> String? {
         return [
             "Location 1",
             "Location 2",
             nil,
             nil,
             "Location 5",
             "Location 6",
             "Location 7",
             "Location 8"
         ][index]
     }

      private func url(at index: Int) -> URL {
         return URL(string: "https://url-\(index + 1).com")!
     }
}
