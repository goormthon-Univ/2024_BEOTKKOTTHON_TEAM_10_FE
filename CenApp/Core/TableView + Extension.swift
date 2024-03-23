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
            cell.dayLabel.text = "D-\(dday)" //데드라인
        }
        return cell
    }
}
class mainSupportTableViewDelegate: NSObject, UITableViewDelegate {
    var scholarships: [ScholarshipModel] = [] // 장학금 데이터 배열
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
//MARK: - 새로운 공고 테이블
class newAnnoucementTableViewDataSource: NSObject, UITableViewDataSource {
    var scholarships: [ScholarshipModel] = [] // 장학금 데이터 배열
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scholarships.count == 0{
            return 0
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
}
