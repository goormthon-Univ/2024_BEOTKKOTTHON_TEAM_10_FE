//
//  AnnoucementDetailViewController.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import UIKit
import SnapKit
import SCLAlertView
import NVActivityIndicatorView
class AnnoucementDetailViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - UIComponent
    var post : ScholarshipModel
    init(post: ScholarshipModel) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //저장하기
    private lazy var saveBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.cGray.cgColor
        btn.layer.borderWidth = 1
        btn.setTitle("저장하기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(saveBtnTapped), for: .touchUpInside)
        return btn
    }()
    //지원하기
    private lazy var supportBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .PrimaryColor
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.setTitle("지원하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(supportBtnTapped), for: .touchUpInside)
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
    //로딩 인디케이터
    private let loadingIndicator :  NVActivityIndicatorView = {
        let view = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20), type: .ballRotateChase, color: .lightGray, padding: 0)
        view.clipsToBounds = true
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = .black
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
        self.view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(30)
            make.center.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(0)
            make.top.equalToSuperview().inset(self.view.frame.height / 10)
            make.bottom.equalToSuperview().offset(-self.view.frame.height / 9)
        }
        saveBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.equalToSuperview().dividedBy(2.5)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-20)
        }
        supportBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalToSuperview().dividedBy(2.5)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-20)
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
            return 220
        case 1:
            return 480
        case 2:
            return 400
        default:
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as? AnnoucementHeaderCell else {
                return UITableViewCell()
            }
            cell.titleLabel.text = post.title
            cell.subLabel.text = post.provider
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as? AnnoucementMiddleCell else {
                return UITableViewCell()
            }
            if let startDate = post.startDate,
               let endDate = post.endDate,
               let target = post.supportTarget,
               let target2 = post.supportTarget2,
               let target3 = post.supportTarget3,
               let amount = post.amount,
               let amount2 = post.amount2,
               let document = post.requiredDocuments {
                cell.periodText.text = "\(startDate) ~ \(endDate)"
                cell.targetText.text = "\(target)분위, \(target2), \(target3)"
                cell.amountText.text = "\(amount)원, \(amount2)원"
                cell.documentText.text = "\(document)"
            }else{}
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdCell", for: indexPath) as? AnnoucementFooterCell else {
                return UITableViewCell()
            }
            if let dec = post.description,
               let dec2 = post.description2,
               let dec3 = post.description3,
               let dec4 = post.description4 {
                cell.infoText.text = "\(dec), \(dec2), \(dec3), \(dec4)"
            }else{}
            return cell
        }
    }
}
//MARK: - Actions
extension AnnoucementDetailViewController {
    @objc private func saveBtnTapped() {
        self.loadingIndicator.startAnimating()
        if let id = post.id {
            AnnoucementService.scholarshipSave(scholarshipId: id){ result in
                self.loadingIndicator.stopAnimating()
                if result?.message == "success" {
                    let alertView = SCLAlertView()
                    alertView.iconTintColor = .PrimaryColor
                    alertView.addButton("캘린더로 이동", backgroundColor: .PrimaryColor, textColor: .white) {
                        self.navigationController?.pushViewController(CalendarViewController(), animated: true)
                    }
                    alertView.showCustom("\n저장이 완료되었습니다!\n", color: .PrimaryColor2, closeButtonTitle: "닫기", colorTextButton: .black)
                }
            } onError: { error in
                self.loadingIndicator.stopAnimating()
                //로그아웃
                LogoutService.requestLogout()
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
        }
    }
    @objc private func supportBtnTapped() {
        if let postSite = post.site {
            if let url = URL(string: postSite) {
                UIApplication.shared.open(url)
            }else { print("존재하지 않는 url") }
        }else{ print("존재하지 않는 url") }
    }
}
