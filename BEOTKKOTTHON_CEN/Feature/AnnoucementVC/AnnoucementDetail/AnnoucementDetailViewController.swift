//
//  AnnoucementDetailViewController.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import UIKit
import SnapKit

class AnnoucementDetailViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - UIComponent
    //저장하기
    private let saveBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.customGray.cgColor
        btn.layer.borderWidth = 1
        btn.setTitle("저장하기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        return btn
    }()
    //지원하기
    private let supportBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .PrimaryColor
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.setTitle("지원하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        return btn
    }()
    //상세 페이지 테이블
    private let tableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.register(AnnoucementHeaderCell.self, forCellReuseIdentifier: "FirstCell")
        view.register(AnnoucementMiddleCell.self, forCellReuseIdentifier: "SecondCell")
        view.register(AnnoucementFooterCell.self, forCellReuseIdentifier: "ThirdCell")
        view.isScrollEnabled = true
        view.clipsToBounds = true
        view.allowsSelection = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
    }
}
//MARK: - setLayout
extension AnnoucementDetailViewController {
    private func setLayout() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        self.view.addSubview(tableView)
        self.view.addSubview(saveBtn)
        self.view.addSubview(supportBtn)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(0)
            make.top.equalToSuperview().inset(self.view.frame.height / 10)
            make.bottom.equalToSuperview().offset(-self.view.frame.height / 9)
        }
        saveBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.equalToSuperview().dividedBy(2.5)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-15)
        }
        supportBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalToSuperview().dividedBy(2.5)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}
//MARK: - setTableView
extension AnnoucementDetailViewController {
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 250
        case 1:
            return 350
        case 2:
            return 800
        default:
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as? AnnoucementHeaderCell else {
                return UITableViewCell()
            }
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as? AnnoucementMiddleCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdCell", for: indexPath) as? AnnoucementFooterCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
}
