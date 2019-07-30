//
//  UserViewModel.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/27/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct UserViewModel {
    // Observerable
    let bag = DisposeBag()
    private(set) var userInfo = PublishRelay<UserModel?>()
    private(set) var newUser = PublishRelay<CreateUserRes?>()
    private(set) var errorString = PublishRelay<String>()
    private(set) var listUser = PublishRelay<[UserModel]?>()
    
    func getUserInfo() {
        UserService.getUserInfo()
            .subscribe(onNext: { (response) in
                // check api code here
//                if response.code == CODE_SUCCESS {
//                    userInfo.accept(response.data)
//                } else {
//                    errorString.accept(response.message)
//                }
                self.userInfo.accept(response.data)
            }, onError: { (error) in
                self.errorString.accept(error.localizedDescription)
            })
            .disposed(by: bag)
    }
    
    func addNewUser() {
        UserService.addNewUser()
            .subscribe(onNext: { (response) in
                self.newUser.accept(response)
            }, onError: { (error) in
                self.errorString.accept(error.localizedDescription)
            })
            .disposed(by: bag)
    }
    
    func getListUser(page: Int, size: Int) {
        UserService.getListUser(page: page, size: size)
            .subscribe(onNext: { (users) in
                self.listUser.accept(users)
            }, onError: { (error) in
                self.errorString.accept(error.localizedDescription)
            })
            .disposed(by: bag)
    }
}
