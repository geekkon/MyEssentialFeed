//
//  FeedCacheTestHelpers.swift
//  MyEssentialFeedTests
//
//  Created by Dim on 16.03.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import Foundation
import MyEssentialFeed

func uniqueImage() -> FeedImage {
    return FeedImage(
        id: UUID(),
        description: "any",
        location: "any",
        url: anyURL()
    )
}

func uniqueImageFeed() -> (models: [FeedImage], local: [LocalFeedImage]) {
    let models = [uniqueImage(), uniqueImage()]
    let local = models.map {
        LocalFeedImage(
            id: $0.id,
            description: $0.description,
            location: $0.location,
            url: $0.url
        )
    }
    return (models: models, local: local)
}

extension Date {

    private var feedCacheMaxAgeInDays: Int {
        return 7
    }

    func minusFeedCacheMaxAge() -> Date {
        return adding(days: -feedCacheMaxAgeInDays)
    }

    private func adding(days: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
}

extension Date {

    func adding(seconds: TimeInterval) -> Date {
        return self + seconds
    }
}
