//
//  RemoteFeedLoader.swift
//  MyEssentialFeed
//
//  Created by Dim on 04.01.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

    public typealias Result = LoadFeedResult

    private let client: HTTPClient
    private let url: URL

    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }

    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(data, response):
                completion(FeedItemsMapper.map(data, response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}
