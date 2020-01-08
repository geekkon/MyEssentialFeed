//
//  HTTPClient.swift
//  MyEssentialFeed
//
//  Created by Dim on 08.01.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
