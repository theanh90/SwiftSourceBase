//
//  UIButton+Extension.swift
//  SwiftSourceBase
//
//  Created by btanh on 8/6/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

extension UIButton {
    @IBInspectable var imageColor: UIColor {
        set {
            let image = self.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
            self.setImage(image, for: .normal)
            self.tintColor = imageColor
        }
        
        get {
            return self.tintColor
        }
    }
}
