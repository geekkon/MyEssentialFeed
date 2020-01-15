//
//  XCTestCase+MemoryLeakTracking.swift
//  MyEssentialFeedTests
//
//  Created by Dim on 15.01.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import XCTest

extension XCTestCase {

    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
