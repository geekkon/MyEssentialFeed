//
//  HTTPClient.swift
//  MyEssentialFeed
//
//  Created by Dim on 08.01.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import Foundation

public protocol HTTPClient {

    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    /// The completion handler can be invoken in any thread
    func get(from url: URL, completion: @escaping (Result) -> Void)
}
