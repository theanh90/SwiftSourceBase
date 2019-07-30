//
//  UserModel.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/26/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

struct UserModel: Codable {
    let id: Int?
    let email: String?
    let first_name: String?
    let last_name: String?
    let avatar: String?
    let name: String?
    let website: String?
}
