//
//  RemoteFeedLoader.swift
//  MyEssentialFeed
//
//  Created by Dim on 04.01.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import Foundation

public protocol HTTPClient {

    func get(from url: URL)
}


public final class RemoteFeedLoader {

    private let client: HTTPClient
    private let url: URL

    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }

    public func load() {
        client.get(from: url)
    }
}

