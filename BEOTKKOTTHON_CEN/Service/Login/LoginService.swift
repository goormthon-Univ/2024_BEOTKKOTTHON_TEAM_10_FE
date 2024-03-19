//
//  LoginService.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/19.
//

import Foundation
import UIKit
import SwiftKeychainWrapper
import Alamofire
class LoginService {
    static func requestLogin(userInfo: LoginModel, completion: @escaping (LoginServiceModel?) -> Void, onError: @escaping (Error) -> Void) {
        let url = "https://www.dolshoi.shop/user/login"
        let body = [
            "userid" : "jjang6251",
            "password" : "1234"
        ]
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: LoginServiceModel.self ) { response in
                switch response.result {
                case .success(let data):
                    if let access = data.accesstoken {
                        let loginServiceModel = LoginServiceModel(message: data.message, accesstoken: access)
                        completion(loginServiceModel)
                    }else { completion(nil) }
                case .failure(let error):
                    onError(error)
                }
            }
    }
}
