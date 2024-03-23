//
//  ScholarshipDayModel.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/21.
//

import Foundation

struct ScholarshipModel : Codable {
    let id: Int?
    let title: String?
    let description: String?
    let description2: String?
    let description3: String?
    let description4: String?
    let provider: String?
    let startDate: String?
    let endDate: String?
    let amount: String?
    let amount2: String?
    let supportRanking: String?
    let supportGrade: String?
    let supportTarget: String?
    let supportTarget2: String?
    let supportTarget3: String?
    let supportCityProvince: String?
    let supportCityCountryDistrict: String?
    let supportMajor: String?
    let requiredDocuments: String?
    let site: String?
    let createdAt: String?
    let dday: Int?
}
