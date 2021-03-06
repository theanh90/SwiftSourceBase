//
//  NetworkUtils.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/26/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import Foundation
import Alamofire

typealias APIFail = (Error) -> Void

// type upload image
typealias MultipartAlamofireImageUpload = (data: Data, name: String, fileName: String, mimeType: String)

struct NetworkUtils<T: Codable> {    
    static func requestAPI(request: RequestApi,
                           header: HTTPHeaders? = nil,
                           successClosure: @escaping ((T) -> Void),
                           failClosure: @escaping APIFail) {
        // Header
        let requestHeader = self.getFullHeader(header: header)
        
        // Alamofire
        Logger.info("Api url: \(request.requestUrl)")
        
        AF.request(request.requestUrl,
                   method: request.requestMethod,
                   parameters: request.requestParam,
                   encoding: JSONEncoding.default,
                   headers: requestHeader)
            .validate()
            .responseJSON { response in
                Logger.info("JSON response: \(response)")
            }
            .responseData { (response) in
                switch response.result {
                case .success:
                    if let data = response.data {
                        // parse data
                        do {
                            let responseObject = try JSONDecoder().decode(T.self, from: data)
                            successClosure(responseObject)
                        } catch {
                            Logger.error("Parse object error: \(error.localizedDescription)")
                            failClosure(error)
                        }
                    } else {
                        let error = NSError(domain: "No data was returned", code: -1, userInfo: nil)
                        Logger.error("API FAIL: No data was returned")
                        failClosure(error)
                    }
                case .failure(let error):
                    Logger.error("API FAIL: \(error.localizedDescription)")
                    failClosure(error)
                }
        }
    }
    
    static func uploadAPIWithDataAndParam(url: String,
                                          params: [String: Any]?,
                                          header: HTTPHeaders? = nil,
                                          listData: [MultipartAlamofireImageUpload],
                                          successClosure: @escaping ((T) -> Void),
                                          failClosure: @escaping APIFail) throws {

        // Header
        let requestHeader = self.getFullHeader(header: header)
                
        if let requestConvetible = try? URLRequest(url: url, method: .post, headers: requestHeader) {
            AF.upload(multipartFormData: { (multipartFormData) in
                // insert data
                for dataParam in listData {
                    multipartFormData.append(dataParam.data,
                                             withName: dataParam.name,
                                             fileName: dataParam.fileName,
                                             mimeType: dataParam.mimeType)
                }
                // insert param
                if let params = params {
                    for (key, value) in params {
                        let valStr = String(describing: value)
                        multipartFormData.append(valStr.data(using: .utf8)!, withName: key)
                    }
                }
            }, with: requestConvetible)
            .responseJSON { (json) in
                Logger.info("JSON response: \(json)")
            }
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    // parse data
                    do {
                        let responseObject = try JSONDecoder().decode(T.self, from: data)
                        successClosure(responseObject)
                    } catch {
                        Logger.error("Parse object error: \(error.localizedDescription)")
                        failClosure(error)
                    }
                case .failure(let error):
                    failClosure(error)
                }
            }
        }
    }
    
    static private func getFullHeader(header: HTTPHeaders?) -> HTTPHeaders? {
        var updatedHeader = header
        
        // Default header
        updatedHeader?.add(name: "Accept", value: "application/json")
        
        // token
        let token = UserDefaultTools.accessToken
        updatedHeader?.add(name: "Authorization", value: "Bearer \(token)")
        
        return updatedHeader
    }
}
