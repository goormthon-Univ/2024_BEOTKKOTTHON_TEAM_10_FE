//
//  TableView + Extension.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import UIKit
//MARK: - 장학금 공고 테이블
class AnnoucementTableViewDataSource: NSObject, UITableViewDataSource {
    var scholarships: [ScholarshipModel] = [] // 장학금 데이터 배열
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scholarships.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell", for: indexPath) as! AnnoucementTableViewCell
        cell.selectionStyle = .none
        
        let scholarship = scholarships[indexPath.row]
        cell.titleText.text = scholarship.title //타이틀
        cell.companyLabel.text = scholarship.provider //제공자
        cell.dayLabel.text = scholarship.endDate //마감일
        if let dday = scholarship.dday {
            if dday > 0 {
                cell.deadlineLabel.text = "D-\(dday)" //데드라인
                if dday <= 3 {
                    cell.deadlineLabel.textColor = .red
                }else {
                    cell.deadlineLabel.textColor = .black
                }
            }else if dday < 0{
                let positiveDday = abs(dday) // 음수인 경우 양수로 변환
                cell.deadlineLabel.text = "D+\(positiveDday)" // "+" 기호를 붙여줌
                if positiveDday <= 3 {
                    cell.deadlineLabel.textColor = .red
                }else {
                    cell.deadlineLabel.textColor = .black
                }
            }else if dday == 0{
                cell.deadlineLabel.text = "D-Day" //데드라인
                cell.deadlineLabel.textColor = .red
            }
        }
        return cell
    }
}
class AnnoucementTableViewDelegate: NSObject, UITableViewDelegate {
    var scholarships: [ScholarshipModel] = []
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scholarship = scholarships[indexPath.row]
        let destinationViewController = AnnoucementDetailViewController(post: scholarship)
        if let navigationController = tableView.window?.rootViewController as? UINavigationController {
            navigationController.pushViewController(destinationViewController, animated: true)
        }
    }
}
//MARK: - 마감임박 테이블
class mainSupportTableViewDataSource: NSObject, UITableViewDataSource {
    var scholarships: [ScholarshipModel] = [] // 장학금 데이터 배열
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scholarships.count == 0 {
            return 0
        }else if scholarships.count < 3 {
            return scholarships.count
        }else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell", for: indexPath) as! MiddleTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .PrimaryColor2
        let scholarship = scholarships[indexPath.row]
        cell.titleLabel.text = scholarship.title
        if let dday = scholarship.dday {
            if dday > 0 {
                cell.dayLabel.text = "D-\(dday)" //데드라인
                if dday <= 3 {
                    cell.dayLabel.textColor = .red
                }else {
                    cell.dayLabel.textColor = .black
                }
            }else if dday < 0{
                let positiveDday = abs(dday) // 음수인 경우 양수로 변환
                cell.dayLabel.text = "D+\(positiveDday)" // "+" 기호를 붙여줌
                if positiveDday <= 3 {
                    cell.dayLabel.textColor = .red
                }else {
                    cell.dayLabel.textColor = .black
                }
            }else if dday == 0{
                cell.dayLabel.text = "D-Day" //데드라인
                cell.dayLabel.textColor = .red
            }
        }
        return cell
    }
}
class mainSupportTableViewDelegate: NSObject, UITableViewDelegate {
    var scholarships: [ScholarshipModel] = [] // 장학금 데이터 배열
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scholarship = scholarships[indexPath.row]
        let destinationViewController = AnnoucementDetailViewController(post: scholarship)
        if let navigationController = tableView.window?.rootViewController as? UINavigationController {
            navigationController.pushViewController(destinationViewController, animated: true)
        }
    }
}
//MARK: - 새로운 공고 테이블
class newAnnoucementTableViewDataSource: NSObject, UITableViewDataSource {
    var scholarships: [ScholarshipModel] = [] // 장학금 데이터 배열
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scholarships.count == 0 {
            return 0
        }else if scholarships.count < 5 {
            return scholarships.count
        }else {
            return 5
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BottomTableViewCell
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        let scholarship = scholarships[indexPath.row]
        cell.titleLabel.text = scholarship.title
        cell.subLabel.text = scholarship.provider
        
        return cell
    }
}
class newAnnoucementTableViewDelegate: NSObject, UITableViewDelegate {
    var scholarships: [ScholarshipModel] = [] // 장학금 데이터 배열
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scholarship = scholarships[indexPath.row]
        let destinationViewController = AnnoucementDetailViewController(post: scholarship)
        if let navigationController = tableView.window?.rootViewController as? UINavigationController {
            navigationController.pushViewController(destinationViewController, animated: true)
        }
    }
}
//MARK: -- 달력 데이터 모델

class CalendarTableViewDelegate : NSObject, UITableViewDelegate {
    var scholarships: [CalendarModel] = [] // 장학금 데이터 배열
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀셀셀 click")
        let scholarship = scholarships[indexPath.row]
        let destinationViewController = AnnoucementDetailViewController(post:ScholarshipModel(id: scholarship.id, title: scholarship.title, description: scholarship.description, description2: scholarship.description2, description3: scholarship.description3, description4: scholarship.description4, provider: scholarship.provider, startDate: scholarship.start_date, endDate: scholarship.end_date, amount: scholarship.amount, amount2: scholarship.amount2, supportRanking: scholarship.supportRanking, supportGrade: scholarship.supportGrade, supportTarget: scholarship.supportTarget, supportTarget2: scholarship.supportTarget2, supportTarget3: scholarship.supportTarget3, supportCityProvince: scholarship.support_city_province, supportCityCountryDistrict: scholarship.support_city_country_district, supportMajor: scholarship.support_major, requiredDocuments: scholarship.required_documents, site: scholarship.site, createdAt: nil, dday: Int(scholarship.d_day!)))
        
        if let currentViewController = UIApplication.shared.keyWindow?.rootViewController {
            // Check if the current view controller is embedded in a navigation controller
            if let navigationController = currentViewController.navigationController {
                navigationController.pushViewController(destinationViewController, animated: true)
            } else {
                // If not embedded in a navigation controller, present the destination view controller
                currentViewController.present(destinationViewController, animated: true, completion: nil)
            }
        }
    }
}

class CalendarTableViewDataSource : NSObject, UITableViewDataSource {
    var scholarships: [CalendarModel] = [] // 장학금 데이터 배열
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scholarships.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CalendarTableViewCell.identifier, for: indexPath) as! CalendarTableViewCell
        //cell.delegate = self //델리게이트 설정
        cell.selectionStyle = .none
        cell.backgroundColor = .PrimaryColor2
        let scholarship = scholarships[indexPath.row]
        cell.dayLabel.text = scholarship.end_date
        cell.companyLabel.text = scholarship.provider
        cell.titleText.text = scholarship.title
        cell.deadlineLabel.text = scholarship.d_day
        switch scholarship.status {
        case "SAVED":
            cell.ingButton.setImage(UIImage(named: "Elipse2"), for: .normal)
        case "APPLYING":
            cell.ingButton.setImage(UIImage(named: "Ellipse"), for: .normal)
        case "COMPLETED":
            cell.ingButton.setImage(UIImage(named: "Ellipse3"), for: .normal)
        default:
            // 기본 이미지 설정 (상태에 따른 이미지가 없는 경우)
            cell.ingButton.setImage(UIImage(named: "Cancel"), for: .normal)
        }
        
        return cell
    }
    
}

