//
//  UIImageView+Extension.swift
//  SwiftSourceBase
//
//  Created by btanh on 8/6/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import Kingfisher

public typealias DownloadImageCompletionHandler = ((_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) -> Void)

extension UIImageView {
    @IBInspectable var isTemplateMode: Bool {
        set {
            var image: UIImage?
            if newValue {
                image = self.image?.withRenderingMode(.alwaysTemplate)
            } else {
                image = self.image?.withRenderingMode(.alwaysOriginal)
            }
            self.image = image
        }
        get {
            if let renderingMode = self.image?.renderingMode, renderingMode == .alwaysTemplate {
                return true
            }
            return false
        }
    }
    
    @IBInspectable var imageColor: UIColor {
        set {
            let image = self.image?.withRenderingMode(.alwaysTemplate)
            self.image = image
            self.tintColor = newValue
        }
        get {
            return self.tintColor
        }
    }
    
    func setImage(with resource: Resource?, placeholder: Placeholder? = #imageLiteral(resourceName: "EmptyProfile.png"), completion: DownloadImageCompletionHandler? = nil) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: resource, placeholder: placeholder, options: [.backgroundDecode], progressBlock: nil, completionHandler: completion)
    }

}
