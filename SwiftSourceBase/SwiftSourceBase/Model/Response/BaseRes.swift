//
//  BaseResponse.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/26/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

struct BaseRes<T: Codable>: Codable {
    let data: T?
    let message: String?
    let code: Int?
}
