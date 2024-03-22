//
//  DocumentService.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/21.
//

import Foundation
import UIKit
import SwiftKeychainWrapper
import Alamofire
class DocumentService {
    //전체 서류
    static func requestDocument(completion: @escaping ([DocumentServiceModel]?) -> Void, onError: @escaping (Error) -> Void) {
        let url = "https://www.dolshoi.shop/document"
        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: [DocumentServiceModel].self ) { response in
                print("\(response.debugDescription)")
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    onError(error)
                }
            }
    }
}
