//
//  String+Extension.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/26/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

extension String {
    func trims() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
