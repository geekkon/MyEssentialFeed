//
//  MyEssentialFeedCacheIntegrationTests.swift
//  MyEssentialFeedCacheIntegrationTests
//
//  Created by Dim on 26.04.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import XCTest
import MyEssentialFeed

class MyEssentialFeedCacheIntegrationTests: XCTestCase {

    override func setUp() {
        super.setUp()

        setupEmptyStoreState()
    }

    override func tearDown() {
        super.tearDown()

        undoStoreSideEffects()
    }

    func test_load_deliversNoItemsOnEmptyCache() {
        let sut = makeSUT()

        expect(sut, toLoad: [])
    }

    func test_load_deliversItemsSavedOnASeparateInstance() {
        let sutToPerformSave = makeSUT()
        let sutToPerformLoad = makeSUT()
        let feed = uniqueImageFeed().models

        save(feed, with: sutToPerformSave)

        expect(sutToPerformLoad, toLoad: feed)
    }

    func test_save_overridesItemsSavedOnASeparateInstance() {
        let sutToPerformFirstSave = makeSUT()
        let sutToPerformLastSave = makeSUT()
        let sutToPerformLoad = makeSUT()
        let firstFeed = uniqueImageFeed().models
        let latestFeed = uniqueImageFeed().models

        save(firstFeed, with: sutToPerformFirstSave)
        save(latestFeed, with: sutToPerformLastSave)

        expect(sutToPerformLoad, toLoad: latestFeed)
    }
}

private extension MyEssentialFeedCacheIntegrationTests {

    func makeSUT(file: StaticString = #file, line: UInt = #line) -> LocalFeedLoader {
        let storeBundle = Bundle(for: CoreDataFeedStore.self)
        let storeURL = testSpecificStoreURL()
        let store = try! CoreDataFeedStore(storeURL: storeURL, bundle: storeBundle)
        let sut = LocalFeedLoader(store: store, currentDate: Date.init)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

    func save(_ feed: [FeedImage], with loader: LocalFeedLoader, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for save completion")
        loader.save(feed) { result in
            if case let Result.failure(error) = result {
                XCTAssertNil(error, "Expected to save feed successfully", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }

    func expect(_ sut: LocalFeedLoader, toLoad expectedFeed: [FeedImage], file: StaticString = #file, line: UInt = #line ) {
        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
                case .success(let loadedFeed):
                    XCTAssertEqual(loadedFeed, expectedFeed, file: file, line: line)
                case .failure(let error):
                    XCTFail("Expected successful feed result, got \(error) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }

    func setupEmptyStoreState() {
        deleteStoreArtifacts()
    }

    func undoStoreSideEffects() {
        deleteStoreArtifacts()
    }

    func deleteStoreArtifacts() {
        try? FileManager.default.removeItem(at: testSpecificStoreURL())
    }

    func testSpecificStoreURL() -> URL {
        return cachesDirectory().appendingPathComponent("\(type(of:self)).store")
    }

    func cachesDirectory() -> URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
}
