//
//  SignupService.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/19.
//

import Foundation
import UIKit
import SwiftKeychainWrapper
import Alamofire
class SignupService {
    static func requestSignup(userInfo: SignupModel, completion: @escaping (SignupServiceModel?) -> Void, onError: @escaping (Error) -> Void) {
        let url = "https://www.dolshoi.shop/user/signup"
        let body = [
            "userid": userInfo.userid,
            "password": userInfo.password,
            "name": userInfo.name
        ]
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: SignupServiceModel.self ) { response in
                switch response.result {
                case .success(let data):
                    let signupServiceModel = SignupServiceModel(message: data.message)
                    completion(signupServiceModel)
                case .failure(let error):
                    onError(error)
                }
            }
    }
}
