//
//  AuthenticateService.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 8/11/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import RxSwift

class AuthenticateService: BaseRxNetwork {
    static func login(userName: String, pass: String) -> Observable<String> {
        var request = PostRequest(url: Server.apiLogin1)
        request.requestParam = ["username": userName, "password": pass]

        return self.callAPIWithObject(request: request)
    }
}
