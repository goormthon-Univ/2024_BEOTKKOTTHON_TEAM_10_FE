//
//  DeviceTokenService.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/23.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper
class DeviceTokenService {
    static func requestDeviceToken(completion: @escaping (DeviceTokenModel) -> Void, onError: @escaping (Error) -> Void) {
        if let JWTaccesstoken = KeychainWrapper.standard.string(forKey: "JWTaccesstoken"),
           let deviceToken = UserDefaults.standard.string(forKey: "deviceToken"){
            let url = "https://www.dolshoi.shop/user/create/devicetoken"
            let body = [
                "devicetoken" : deviceToken
            ]
            AF.request(url, method: .post, parameters: body , encoding: JSONEncoding.default, headers: ["accesstoken" : JWTaccesstoken])
                .validate()
                .responseDecodable(of: DeviceTokenModel.self ) { response in
                    print("디바이스 토큰 \(response.debugDescription)")
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
