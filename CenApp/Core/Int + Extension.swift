//
//  Int + Extension.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/21.
//

import Foundation
extension Int {
    func formattedDday() -> String {
            guard self >= 0 else { return "" }
            return "D-\(self)"
        }
}
