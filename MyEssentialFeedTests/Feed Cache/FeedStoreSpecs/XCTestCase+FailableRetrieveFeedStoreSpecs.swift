//
//  XCTestCase+FailableRetrieveFeedStoreSpecs.swift
//  MyEssentialFeedTests
//
//  Created by Dim on 09.04.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import XCTest
import MyEssentialFeed

extension FailableRetrieveFeedStoreSpecs where Self: XCTestCase {

    func assertThatRetrieveDeliversFailureOnRetrievalError(
        on sut: FeedStore,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        expect(sut, toRetrieve: .failure(anyNSError()), file: file, line: line)
    }

    func assertThatRetrieveHasNoSideEffectsOnRetrievalError(
        on sut: FeedStore,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        expect(sut, toRetrieveTwice: .failure(anyNSError()), file: file, line: line)
    }
}
