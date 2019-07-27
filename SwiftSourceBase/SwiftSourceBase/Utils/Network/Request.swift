//
//  Request.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/27/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import Alamofire

protocol RequestApi {
    var requestUrl: String { get set }
    var requestParam: [String: Any]? { get set }
    var requestMethod: HTTPMethod { get }
}

struct GetRequest: RequestApi {
    var requestUrl: String
    var requestParam: [String: Any]?
    var requestMethod: HTTPMethod = .get
    
    init(url: String) {
        requestUrl = url
    }
}

struct PostRequest: RequestApi {
    var requestUrl: String
    var requestParam: [String: Any]?
    var requestMethod: HTTPMethod = .post
    
    init(url: String) {
        requestUrl = url
    }
}
