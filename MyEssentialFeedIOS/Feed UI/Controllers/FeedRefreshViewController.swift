//
//  FeedRefreshViewController.swift
//  MyEssentialFeedIOS
//
//  Created by Dim on 14.05.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import UIKit
import MyEssentialFeed

final class FeedRefreshViewController: NSObject {

    private (set) lazy var view: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }()

    private let feedLoader: FeedLoader

    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
        super.init()
    }

    var onRefresh: (([FeedImage]) -> Void)?

    @objc func refresh() {
        view.beginRefreshing()
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onRefresh?(feed)
            }
            self?.view.endRefreshing()
        }
    }
}
