//
//  AmountService.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/22.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper
class AmountService {
    static func requestAmount(completion: @escaping (AmountServiceModel?) -> Void, onError: @escaping (Error) -> Void) {
        if let JWTaccesstoken = KeychainWrapper.standard.string(forKey: "JWTaccesstoken") {
            let url = "https://www.dolshoi.shop/scholarship/user/amount"
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: ["accesstoken" : JWTaccesstoken])
                .validate()
                .responseDecodable(of: AmountServiceModel.self ) { response in
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
