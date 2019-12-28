//
//  FeedLoader.swift
//  MyEssentialFeed
//
//  Created by Dim on 28.12.2019.
//  Copyright © 2019 Dmitriy Baklanov. All rights reserved.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
