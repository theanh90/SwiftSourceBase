//
//  StoryboardName.swift
//  SwiftSourceBase
//
//  Created by btanh on 7/30/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

enum StoryboardName: String {
    case main = "Main"
    case userStoryboard = "UserStoryboard"
}

protocol Storyboarded { }
extension Storyboarded where Self: UIViewController {
    static func instantiate(name storyboard: String? = nil) -> Self {
        let name = storyboard ?? "Main"
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
