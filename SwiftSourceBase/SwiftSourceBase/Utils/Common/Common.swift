//
//  Common.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 8/1/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

protocol Identified {
    static var cellId: String { get }
}

extension Identified {
    static var cellId: String {
        return "\(self)"
    }
}

typealias EmptyClosure = () -> Void
