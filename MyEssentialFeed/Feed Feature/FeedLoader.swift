//
//  FeedLoader.swift
//  MyEssentialFeed
//
//  Created by Dim on 28.12.2019.
//  Copyright © 2019 Dmitriy Baklanov. All rights reserved.
//

import Foundation

public protocol FeedLoader {

    typealias Result = Swift.Result<[FeedImage], Error>

    func load(completion: @escaping (Result) -> Void)
}
