//
//  CalenderService.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/24.
//

import Foundation
import SwiftKeychainWrapper
import Alamofire
class CalenderService {
    //지원 중
    static func requestApplying(info: Int, status : String,completion: @escaping (AmountServiceModel?) -> Void, onError: @escaping (Error) -> Void) {
        if let JWTaccesstoken = KeychainWrapper.standard.string(forKey: "JWTaccesstoken") {
            let url = "https://www.dolshoi.shop/scholarship/each/status"
            let body : [String:Any] = [
                "scholarshipId": info,
                "status" : status
            ]
            AF.request(url, method: .post, parameters: body ,encoding: JSONEncoding.default, headers: ["accesstoken" : JWTaccesstoken])
                .validate()
                .responseDecodable(of: AmountServiceModel.self ) { response in
                    print("서비스! : \(response.debugDescription)")
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
    static func deleteCalender(scholarshipId : Int ,completion: @escaping (CalendarModel?) -> Void, onError: @escaping (Error) -> Void) {
        if let JWTaccesstoken = KeychainWrapper.standard.string(forKey: "JWTaccesstoken") {
            let url = "https://www.dolshoi.shop/scholarship/each/cancel"
            let body = [
                "scholarshipId" : scholarshipId
            ]
            AF.request(url, method: .post, parameters: body , encoding: JSONEncoding.default, headers: ["accesstoken" : JWTaccesstoken])
                .validate()
                .responseDecodable(of: CalendarModel.self ) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        onError(error)
                    }
                }
        }
    }
}
