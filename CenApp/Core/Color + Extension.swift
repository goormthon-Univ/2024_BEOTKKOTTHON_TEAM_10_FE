//
//  Color + Extension.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/16.
//

import Foundation
import UIKit

extension UIColor {
    static var PrimaryColor : UIColor {
        return UIColor(named: "PrimaryColor") ?? .white
    }
    static var SecondaryColor : UIColor {
        return UIColor(named: "SecondaryColor") ?? .white
    }
    static var ThirdaryColor : UIColor {
        return UIColor(named: "ThirdaryColor") ?? .white
    }
    static var cGray : UIColor {
        return UIColor(named: "customGray") ?? .white
    }
    static var cLightGray : UIColor {
        return UIColor(named: "customLightGray") ?? .white
    }
    static var PrimaryColor2 : UIColor {
        return UIColor(named: "PrimaryColor2") ?? .white
    }
    static var cred : UIColor {
        return UIColor(named: "customRed") ?? .white
    }
}
