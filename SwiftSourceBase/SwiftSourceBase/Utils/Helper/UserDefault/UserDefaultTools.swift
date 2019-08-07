//
//  UserDefaultTools.swift
//  SwiftSourceBase
//
//  Created by btanh on 8/7/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

class UserDefaultTools {
    private static let shared = UserDefaults.standard
    
    static var accessToken: String {
        get {
            return shared.string(forKey: SaveKey.accessToken.rawValue) ?? ""
        }
        set {
            shared.set(newValue, forKey: SaveKey.accessToken.rawValue)
        }
    }
    
    static var userInfo: UserModel? {
        get {
            guard let userPro: UserModel = (shared.dictionary(forKey: SaveKey.userInfo.rawValue)?.decoded()) else { return nil }
            return userPro
        }
        set {
            shared.set(newValue?.asDictionary(), forKey: SaveKey.userInfo.rawValue)
        }
    }
}
