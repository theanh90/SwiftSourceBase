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

struct GoogleKey {
    static let clientId = "886499438572-ac25i2pqgfqmo1lri81eunq4njl49s58.apps.googleusercontent.com"
    static let revertClientId = "com.googleusercontent.apps.886499438572-ac25i2pqgfqmo1lri81eunq4njl49s58"
}

struct FacebookKey {
    static let fbId = "fb405564923404602"
}
