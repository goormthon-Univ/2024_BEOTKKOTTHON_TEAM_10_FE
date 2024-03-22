//
//  DocumentServiceModel.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/21.
//

import Foundation
struct DocumentServiceModel : Codable {
    let ㄱ, ㄴ, ㄷ : [Document]
//    ㄱ, ㄴ, ㄷ, ㄹ, ㅁ, ㅂ, ㅅ, ㅇ, ㅈ, ㅊ, ㅋ, ㅌ, ㅍ, ㅎ
}
struct Document: Codable {
    let id: Int
    let title: String
    let site: String?
}
