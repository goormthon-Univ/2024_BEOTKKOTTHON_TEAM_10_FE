//
//  FindpwService.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/22.
//

import Foundation
import UIKit
import SwiftKeychainWrapper
import Alamofire
class FindpwService {
    static func requestFindpw(userInfo: FindpwModel, completion: @escaping (FindpwServiceModel?) -> Void, onError: @escaping (Error) -> Void) {
        let url = "https://www.dolshoi.shop/user/change/password"
        let body = [
            "userid": userInfo.userid,
            "password": userInfo.password,
            "name": userInfo.name
        ]
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: FindpwServiceModel.self ) { response in
                print("통신 \(response)")
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    onError(error)
                }
            }
    }
}
