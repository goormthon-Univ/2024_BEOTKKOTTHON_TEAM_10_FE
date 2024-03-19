//
//  ExpressionService.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/19.
//

import Foundation
import UIKit
import SwiftKeychainWrapper
import Alamofire
class ExpressionService {
    static func requestExpression(errorMessage : String) -> String?{
        let pattern = #"Response status code was unacceptable: (\d+)"#
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        if let match = regex.firstMatch(in: errorMessage, options: [], range: NSRange(errorMessage.startIndex..., in: errorMessage)) {
            let range = match.range(at: 1)
            
            if let swiftRange = Range(range, in: errorMessage) {
                let errorCode = errorMessage[swiftRange]
                return String(errorCode)
            }
        } else {
            print("에러 코드를 찾을 수 없습니다.")
        }
        return nil
    }
}
