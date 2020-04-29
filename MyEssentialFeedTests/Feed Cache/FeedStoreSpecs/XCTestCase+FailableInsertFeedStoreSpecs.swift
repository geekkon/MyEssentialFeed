//
//  XCTestCase+FailableInsertFeedStoreSpecs.swift
//  MyEssentialFeedTests
//
//  Created by Dim on 09.04.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import XCTest
import MyEssentialFeed

extension FailableInsertFeedStoreSpecs where Self: XCTestCase {
    
    func assertThatInsertDeliversErrorOnInsertionError(
        on sut: FeedStore,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let insertionError = insert((uniqueImageFeed().local, Date()), to: sut)

        XCTAssertNotNil(insertionError, "Expected cache insertion to fail with an error", file: file, line: line)
    }

    func assertThatInsertHasNoSideEffectsOnInsertionError(
        on sut: FeedStore,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        insert((uniqueImageFeed().local, Date()), to: sut)

        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
}
