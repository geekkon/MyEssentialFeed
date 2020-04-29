//
//  FeedStore.swift
//  MyEssentialFeed
//
//  Created by Dim on 10.03.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import Foundation

public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)

public protocol FeedStore {

    typealias DeletionResult = Result<Void, Error>
    typealias DeletionCompletion = (DeletionResult) -> Void

    typealias InsertionResult = Result<Void, Error>
    typealias InsertionCompletion = (InsertionResult) -> Void

    typealias RetrievalResult = Result<CachedFeed?, Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void

    /// The completion handler can be invoken in any thread
    func deleteCachedFeed(completion: @escaping DeletionCompletion)

    /// The completion handler can be invoken in any thread
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    
    /// The completion handler can be invoken in any thread
    func retrieve(completion: @escaping RetrievalCompletion)
}
