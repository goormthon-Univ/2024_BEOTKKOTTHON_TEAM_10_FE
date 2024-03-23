//
//  AnnoucementService.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/21.
//

import Foundation
import UIKit
import SwiftKeychainWrapper
import Alamofire
class AnnoucementService {
    //전체 장학금(마감순)
    static func scholarshipDay(completion: @escaping ([ScholarshipModel]?) -> Void, onError: @escaping (Error) -> Void) {
        if let JWTaccesstoken = KeychainWrapper.standard.string(forKey: "JWTaccesstoken") {
            let url = "https://www.dolshoi.shop/scholarship/user"
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: ["accesstoken" : JWTaccesstoken])
                .validate()
                .responseDecodable(of: [ScholarshipModel].self ) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        onError(error)
                    }
                }
        }
    }
    //전체 장학금(최신순)
    static func scholarshipNew(completion: @escaping ([ScholarshipModel]?) -> Void, onError: @escaping (Error) -> Void) {
        if let JWTaccesstoken = KeychainWrapper.standard.string(forKey: "JWTaccesstoken") {
            let url = "https://www.dolshoi.shop/scholarship/user/update"
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: ["accesstoken" : JWTaccesstoken])
                .validate()
                .responseDecodable(of: [ScholarshipModel].self ) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        onError(error)
                    }
                }
        }
    }
    //장학금 저장
    static func reqeustSave(scholarshipId : Int ,completion: @escaping (SaveServiceModel?) -> Void, onError: @escaping (Error) -> Void) {
        if let JWTaccesstoken = KeychainWrapper.standard.string(forKey: "JWTaccesstoken") {
            let url = "https://www.dolshoi.shop/scholarship/each/save"
            let body = [
                "scholarshipId" : scholarshipId
            ]
            AF.request(url, method: .post, parameters: body ,encoding: JSONEncoding.default, headers: ["accesstoken" : JWTaccesstoken])
                .validate()
                .responseDecodable(of: SaveServiceModel.self ) { response in
                    print("저장 : \(response.debugDescription)")
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
