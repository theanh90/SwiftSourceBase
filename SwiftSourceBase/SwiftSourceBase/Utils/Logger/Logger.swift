//
//  Logger.swift
//  SwiftSourceBase
//
//  Created by btanh on 7/23/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

class Logger {
    private init() {}
    
    enum LoggerType {
        case info
        case warning
        case error
        
        func logTitle() -> String {
            switch self {
            case .info:
                return "Log info: 💚"
            case .warning:
                return "Log warning: 💛"
            default:
                return "Log error: 💔 🐞 🐞 🐞 💔"
            }
        }
    }
    
    // MARK: - Public method
    static func info(_ content: String, file: String = #file, line: Int = #line, function: String = #function) {
        showLog(type: .info, content: content, file: file, line: line, function: function)
    }
    
    static func warning(_ content: String, file: String = #file, line: Int = #line, function: String = #function) {
        showLog(type: .warning, content: content, file: file, line: line, function: function)
    }
    
    static func error(_ content: String, file: String = #file, line: Int = #line, function: String = #function) {
        showLog(type: .error, content: content, file: file, line: line, function: function)
    }
    
    // MARK: - Private method
    private static func showLog(type: LoggerType, content: String, file: String, line: Int, function: String) {
        let fileName = file.components(separatedBy: "/").last ?? " "
        print(String.init(format: "%@ - %@[%@:%d] - %@", type.logTitle(), fileName, function, line, content))
    }
}
