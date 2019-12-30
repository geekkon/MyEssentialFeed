//
//  RemoteFeedLoaderTests.swift
//  MyEssentialFeedTests
//
//  Created by Dim on 31.12.2019.
//  Copyright © 2019 Dmitriy Baklanov. All rights reserved.
//

import XCTest

class RemoteFeedLoader {

    let client: HTTPClient
    let url: URL

    init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }

    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {

    func get(from url: URL)
}


class RemoteFeedLoaderTests: XCTestCase {

    private class HTTPClientSpy: HTTPClient {

        var requestedURL: URL?

        func get(from url: URL) {
            requestedURL = url
        }
    }

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()

        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.load()

        XCTAssertNotNil(client.requestedURL)
    }

    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let loader = RemoteFeedLoader(client: client, url: url)
        return (sut: loader, client: client)
    }
}
