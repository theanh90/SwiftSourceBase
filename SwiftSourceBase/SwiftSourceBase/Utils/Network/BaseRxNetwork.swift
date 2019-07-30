//
//  Network.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/27/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

protocol BaseRxNetwork {
    static func callAPIWithObject<T: Codable>(request: RequestApi, header: HTTPHeaders?) -> Observable<T>
}

extension BaseRxNetwork {
    static func callAPIWithObject<T: Codable>(request: RequestApi, header: HTTPHeaders? = nil) -> Observable<T> {
        return Observable.create({ (observer) -> Disposable in
            NetworkUtils<T>.requestAPI(request: request, header: header, successClosure: { (response) in
                observer.onNext(response)
                observer.onCompleted()
            }) { (error) in
                observer.onError(error)
                observer.onCompleted()
            }
            
            return Disposables.create()
        })
    }
}
