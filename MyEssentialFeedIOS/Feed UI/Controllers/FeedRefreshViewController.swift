//
//  FeedRefreshViewController.swift
//  MyEssentialFeedIOS
//
//  Created by Dim on 14.05.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import UIKit

final class FeedRefreshViewController: NSObject {

    private (set) lazy var view = binded(UIRefreshControl())

    private let viewModel: FeedViewModel

    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    @objc func refresh() {
        viewModel.loadFeed()
    }

    private func binded(_ view: UIRefreshControl) -> UIRefreshControl {
        viewModel.onLoadingStateChange = { [weak view] isLoading in
            if isLoading {
                view?.beginRefreshing()
            } else {
                view?.endRefreshing()
            }
        }
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}
