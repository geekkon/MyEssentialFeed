//
//  FeedItem.swift
//  MyEssentialFeed
//
//  Created by Dim on 28.12.2019.
//  Copyright © 2019 Dmitriy Baklanov. All rights reserved.
//

import Foundation

struct FeedItem {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
