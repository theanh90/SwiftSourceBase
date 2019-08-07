//
//  Dictionary+Extension.swift
//  SwiftSourceBase
//
//  Created by btanh on 8/7/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

extension Dictionary where Key == String {
    func decoded<T: Codable>() -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else { return nil }
        var result: T?
        do {
            result = try JSONDecoder().decode(T.self, from: data)
        } catch {
            Logger.error("Parse dictionary to object error: \(error.localizedDescription)")
        }
        return result
    }
}
