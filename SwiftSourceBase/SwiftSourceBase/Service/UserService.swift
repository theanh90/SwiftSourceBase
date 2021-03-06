//
//  UserService.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/27/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import RxSwift

class UserService: BaseRxNetwork {
    static func getUserInfo() -> Observable<BaseRes<UserModel>> {
        let request = GetRequest(url: Server.apiGetUser)
        
        return self.callAPIWithObject(request: request)
    }
    
    static func addNewUser() -> Observable<CreateUserRes> {
        let paramObj = CreateUserReq(name: "testpost2", job: "tester")
        var request = PostRequest(url: Server.apiAddUser)
        request.requestParam = paramObj.asDictionary()
        
        return self.callAPIWithObject(request: request)
    }
    
    static func getListUser(page: Int, size: Int) -> Observable<[UserModel]> {
        #warning("Need add page and size here")
        let request = GetRequest(url: Server.apiListUser)
        
        return self.callAPIWithObject(request: request)
    }
    
    static func login(_ param: LoginReq) -> Observable<LoginData> {
        var request = PostRequest(url: Server.apiLogin)
        request.requestParam = param.asDictionary()
        
        return self.callAPIWithObject(request: request)
    }
}
