//
//  RemoteFeedItem.swift
//  MyEssentialFeed
//
//  Created by Dim on 12.03.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import Foundation

 struct RemoteFeedItem: Decodable {
     let id: UUID
     let description: String?
     let location: String?
     let image: URL
}
