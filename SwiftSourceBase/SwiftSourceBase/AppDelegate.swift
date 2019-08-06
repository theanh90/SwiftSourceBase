//
//  AppDelegate.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/21/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import Localize
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Test logging
        Logger.info("Finish launch at AppDelegate")
        Logger.warning("Finish launch at AppDelegate")
        Logger.error("Finish launch at AppDelegate")
        
        // Support multiple languages
        localizeConfig()
        
        // Enable IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// MARK: - Localize
extension AppDelegate {
    private func localizeConfig() {
        // Set your localize provider.
        Localize.update(provider: .strings)
        // Set your file name
        Localize.update(fileName: "Localizable")
        // Set your default languaje.
        Localize.update(defaultLanguage: "en")
        Localize.update(language: "vi-VN")
    }
}
