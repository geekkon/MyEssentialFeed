//
//  FeedStore.swift
//  MyEssentialFeed
//
//  Created by Dim on 10.03.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import Foundation

public enum RetrieveCachedFeedResult {
    case empty
    case found(feed: [LocalFeedImage], timestamp: Date)
    case failure(Error)
}

public protocol FeedStore {

    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (RetrieveCachedFeedResult) -> Void

    /// The completion handler can be invoken in any thread
    func deleteCachedFeed(completion: @escaping DeletionCompletion)

    /// The completion handler can be invoken in any thread
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    
    /// The completion handler can be invoken in any thread
    func retrieve(completion: @escaping RetrievalCompletion)
}
