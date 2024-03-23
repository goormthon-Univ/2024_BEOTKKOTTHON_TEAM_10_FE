//
//  HashtagServiceModel.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/23.
//

import Foundation
struct HashtagServiceModel : Codable {
    let ranking : String
    let grade : String
    let region_city_province : String
    let region_city_country_district : String
    let major : String
}
