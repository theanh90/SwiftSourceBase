//
//  UIDevice+Extension.swift
//  SwiftSourceBase
//
//  Created by btanh on 8/6/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

extension UIDevice {
    static var isIphone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
