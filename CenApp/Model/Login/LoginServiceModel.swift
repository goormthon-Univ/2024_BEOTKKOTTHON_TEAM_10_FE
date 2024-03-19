//
//  LoginServiceModel.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/19.
//

import Foundation
struct LoginServiceModel: Codable {
    let message: String
    let accesstoken: String?
    
    enum CodingKeys: String, CodingKey {
        case message
        case accesstoken = "accesstoken"
    }
}
