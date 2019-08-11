//
//  AuthenticateViewModel.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 8/11/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AuthenticateViewModel {
    // Observerable
    let bag = DisposeBag()
    private(set) var loginData = PublishRelay<String?>()

    func login(username: String, pass: String) {
        AuthenticateService.login(userName: username, pass: pass)
            .subscribe(onNext: { (data) in
                Logger.info("Login data: \(data)")
            }, onError: { (error) in
                Logger.error("Login error: \(error.localizedDescription)")
            })
            .disposed(by: bag)
    }

}
