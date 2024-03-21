//
//  LoginCheckService.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/21.
//

import Foundation
import SnapKit
import Alamofire
import UIKit
import SwiftKeychainWrapper

class LoginCheckService {
    static func requestLogin(completion: @escaping (LoginCheckModel?) -> Void, onError: @escaping (Error) -> Void) {
        if let JWTaccesstoken = KeychainWrapper.standard.string(forKey: "JWTaccesstoken") {
            let url = "https://www.dolshoi.shop/user/login/check"
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: ["accesstoken" : JWTaccesstoken])
                .validate()
                .responseDecodable(of: LoginCheckModel.self ) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        onError(error)
                    }
                }
        }else {
            
        }
    }
}
