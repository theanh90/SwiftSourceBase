//
//  Codable+Extension.swift
//  SwiftSourceBase
//
//  Created by btanh on 7/30/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

// MARK: - Encode from objective to dictionary
extension Encodable {
    func asDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return nil
            }
            return dictionary
        } catch {
            return nil
        }
    }
}
