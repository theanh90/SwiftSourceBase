//
//  WindowPopup.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/28/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

class WindowPopup {
    private init() {}
    
    // MARK: - Private variable
    static private var controller: UIViewController?
    static private var window: UIWindow?
    
    // MARK: - Private method
    static private func hidePopup() {
        controller = nil
        window?.removeFromSuperview()
        window = nil
    }
}

// MARK: - Loading view
extension WindowPopup {
    // Alert view
    static func showAlert(_ content: String, title: String? = nil, yesBlock: EmptyClosure? = nil, noBlock: EmptyClosure? = nil) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowLevel = UIWindow.Level.alert + 1
        let alertVC = AlertVC()
        alertVC.yesBlock = yesBlock
        alertVC.noBlock = noBlock
        alertVC.titleAlert = title
        alertVC.contentAlert = content
        
        controller = alertVC
        
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
    
    // Loading view
    static func showLoading() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowLevel = UIWindow.Level.alert + 1
        controller = LoadingVC()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
    
    static func hideLoading() {
        hidePopup()
    }
}
