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
        let url = "https://www.dolshoi.shop/scholarship/all"
        AF.request(url, method: .get, encoding: JSONEncoding.default)
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
    //전체 장학금(최신순)
    static func scholarshipNew(completion: @escaping ([ScholarshipModel]?) -> Void, onError: @escaping (Error) -> Void) {
        let url = "https://www.dolshoi.shop/scholarship/all/new"
        AF.request(url, method: .get, encoding: JSONEncoding.default)
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
