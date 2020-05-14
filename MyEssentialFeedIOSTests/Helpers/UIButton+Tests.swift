//
//  UIButton+Tests.swift
//  MyEssentialFeedIOSTests
//
//  Created by Dim on 14.05.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import UIKit

extension UIButton {

    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
