//
//  CodableFeedStore.swift
//  MyEssentialFeed
//
//  Created by Dim on 05.04.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import Foundation

public class CodableFeedStore: FeedStore {

    private struct CodableFeedImage: Codable {

        private let id: UUID
        private let description: String?
        private let location: String?
        private let url: URL

        init(_ image: LocalFeedImage) {
            self.id = image.id
            self.description = image.description
            self.location = image.location
            self.url = image.url

        }

        var local: LocalFeedImage {
            return LocalFeedImage(
                id: id,
                description: description,
                location: location,
                url: url
            )
        }
    }

    private struct Cache: Codable {

        let feed: [CodableFeedImage]
        let timestamp: Date

        var localFeed: [LocalFeedImage] {
            return feed.map { $0.local }
        }
    }

    private let storeURL: URL

    public init(storeURL: URL) {
        self.storeURL = storeURL
    }

    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        guard FileManager.default.fileExists(atPath: storeURL.path) else {
            return completion(nil)
        }
        do {
            try FileManager.default.removeItem(at: storeURL)
            completion(nil)
        } catch {
            completion(error)
        }
    }

    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        do {
            let cache = Cache(feed: feed.map(CodableFeedImage.init), timestamp: timestamp)
            let data = try JSONEncoder().encode(cache)
            try data.write(to: storeURL)
            completion(nil)
        } catch {
            completion(error)
        }
    }

    public func retrieve(completion: @escaping RetrievalCompletion) {
        guard let data = try? Data(contentsOf: storeURL) else {
            return completion(.empty)
        }
        do {
            let cache = try JSONDecoder().decode(Cache.self, from: data)
            completion(.found(feed: cache.localFeed, timestamp: cache.timestamp))
        } catch {
            completion(.failure(error))
        }
    }
}
