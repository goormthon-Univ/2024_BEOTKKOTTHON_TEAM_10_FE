//
//  CalendarCountAPI.swift
//  CenApp
//
//  Created by 김민솔 on 3/24/24.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class CalendarCountAPI {
    static func fetchMonthData(year: String, month: String, completion: @escaping ([String]?) -> Void, onError: @escaping (Error) -> Void) {
        if let JWTaccesstoken = KeychainWrapper.standard.string(forKey: "JWTaccesstoken") {
            let url = "https://www.dolshoi.shop/count/end/\(year)/\(month)"
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: ["accesstoken" : JWTaccesstoken])
                .validate()
                .responseDecodable(of: [String].self ) { response in
                    print(response.debugDescription)
                    switch response.result {
                    case .success(let data):
                        
                        completion(data)
                        print("enddate 호출성공")
                    case .failure(let error):
                        onError(error)
                    }
                }
        } else {
            // JWTaccesstoken이 없는 경우에 대한 처리
        }
    }
}
