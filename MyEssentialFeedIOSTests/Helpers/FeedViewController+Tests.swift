//
//  FeedViewController+Tests.swift
//  MyEssentialFeedIOSTests
//
//  Created by Dim on 14.05.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import UIKit
import MyEssentialFeedIOS

extension FeedViewController {

    func simulateUserInitiatedFeedReload() {
        refreshControl?.simulatePullToRefresh()
    }

    @discardableResult
    func simulateFeedImageViewVisible(at index: Int) -> FeedImageCell? {
        return feedImageView(at: index) as? FeedImageCell
    }

    func simulateFeedImageViewNotVisible(at row: Int) {
        let view = simulateFeedImageViewVisible(at: row)

        let delegate = tableView.delegate
        let index = IndexPath(row: row, section: feedImagesSection)
        delegate?.tableView?(tableView, didEndDisplaying: view!, forRowAt: index)
    }

    func simualteFeedImageViewNearVisible(at row: Int) {
        let prefetchDataSource = tableView.prefetchDataSource
        let index = IndexPath(row: row, section: feedImagesSection)
        prefetchDataSource?.tableView(tableView, prefetchRowsAt: [index])
    }

    func simualteFeedImageViewNotNearVisible(at row: Int) {
        simualteFeedImageViewNearVisible(at: row)

        let prefetchDataSource = tableView.prefetchDataSource
        let index = IndexPath(row: row, section: feedImagesSection)
        prefetchDataSource?.tableView?(tableView, cancelPrefetchingForRowsAt: [index])
    }

    var isShowingLoadingIndicator: Bool {
        return refreshControl?.isRefreshing == true
    }

    func numberOfRenderedFeedImageViews() -> Int {
        return tableView.numberOfRows(inSection: feedImagesSection)
    }

    func feedImageView(at row: Int) -> UITableViewCell? {
        let dataSource = tableView.dataSource
        let index = IndexPath(row: row, section: feedImagesSection)
        return dataSource?.tableView(tableView, cellForRowAt: index)
    }

    private var feedImagesSection: Int {
        return 0
    }
}
