//
//  CalendarDayAPI.swift
//  CenApp
//
//  Created by 김민솔 on 3/23/24.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper
class CalendarDayAPI {
    static func fetchMonthData(year: String, month: String,day: String, completion: @escaping ([CalendarModel]?) -> Void, onError: @escaping (Error) -> Void) {
        if let JWTaccesstoken = KeychainWrapper.standard.string(forKey: "JWTaccesstoken") {
            let url = "https://www.dolshoi.shop/calendar/\(year)/\(month)/\(day)"
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: ["accesstoken" : JWTaccesstoken])
                .validate()
                .responseDecodable(of: [CalendarModel].self ) { response in
                    print(response.debugDescription)
                    switch response.result {
                    case .success(let data):
                        completion(data)
                        print("호출성공")
                    case .failure(let error):
                        onError(error)
                    }
                }
        }else {
            
        }
    }
}

