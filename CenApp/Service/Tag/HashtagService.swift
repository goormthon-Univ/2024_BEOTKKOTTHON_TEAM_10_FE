//
//  TagService.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/23.
//

import Foundation
import UIKit
import SwiftKeychainWrapper
import Alamofire
class HashtagService {
    //전체 서류
    static func requestTag(completion: @escaping (HashtagServiceModel) -> Void, onError: @escaping (Error) -> Void) {
        if let JWTaccesstoken = KeychainWrapper.standard.string(forKey: "JWTaccesstoken") {
            let url = "https://www.dolshoi.shop/user/hashtag"
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: ["accesstoken" : JWTaccesstoken])
                .validate()
                .responseDecodable(of: HashtagServiceModel.self ) { response in
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
