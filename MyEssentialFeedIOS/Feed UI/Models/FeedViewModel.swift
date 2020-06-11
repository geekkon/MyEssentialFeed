//
//  FeedViewModel.swift
//  MyEssentialFeedIOS
//
//  Created by Dim on 11.06.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import Foundation
import MyEssentialFeed

final class FeedViewModel {

    typealias Observer<T> = (T) -> Void

    private let feedLoader: FeedLoader

    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }

    var onLoadingStateChange: Observer<Bool>?
    var onFeedLoad: Observer<[FeedImage]>?

    func loadFeed() {
        onLoadingStateChange?(true)
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedLoad?(feed)
            }
            self?.onLoadingStateChange?(false)
        }
    }
}
