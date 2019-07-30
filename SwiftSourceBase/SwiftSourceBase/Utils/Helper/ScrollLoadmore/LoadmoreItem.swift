//
//  LoadmoreItem.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 8/1/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

let PAGING_SIZE = 10

struct LoadmoreItem {
    var page = 0
    var size = PAGING_SIZE
    var hasLoadmore = false
    
    mutating func reset() {
        self.page = 0
        self.hasLoadmore = false
    }
}
