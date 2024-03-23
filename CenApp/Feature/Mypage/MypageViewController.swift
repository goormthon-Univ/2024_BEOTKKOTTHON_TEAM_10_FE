//
//  MypageViewController.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/23.
//

import Foundation
import UIKit
import SnapKit
import NVActivityIndicatorView
class MyPageViewController : UIViewController {
    //타이틀
    //상위 뷰
    private let headerView : UIView = {
        let view = UIView()
        view.backgroundColor = .PrimaryColor2
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "회원정보"
        label.textColor = .black
        label.backgroundColor = .PrimaryColor2
        label.textAlignment = .left
        label.clipsToBounds = true
        return label
    }()
    //아이콘
    private let personIcon : UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        view.tintColor = .PrimaryColor2
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    //온보딩
    //해시테그
    private let checkScrollView : UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.clipsToBounds = true
        return view
    }()
    private let checkStackView : UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fill
        return view
    }()
    //로그아웃
    private lazy var logoutBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("로그아웃", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(logoutBtnTapped), for: .touchUpInside)
        btn.backgroundColor = .PrimaryColor
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        return btn
    }()
    //온보딩 수정
    private lazy var onboardingBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("온보딩 수정", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(onboardingBtnTapped), for: .touchUpInside)
        btn.backgroundColor = .PrimaryColor
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        return btn
    }()
    //로딩 인디케이터
    private let loadingIndicator :  NVActivityIndicatorView = {
        let view = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20), type: .ballRotateChase, color: .lightGray, padding: 0)
        view.clipsToBounds = true
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = .PrimaryColor2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        fetchHashTag()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.backgroundColor = .white
    }
}
//MARK: - UI Layout
extension MyPageViewController {
    private func setLayout() {
        self.view.backgroundColor = .white
        
        self.headerView.addSubview(titleLabel)
        self.view.addSubview(headerView)
        self.view.addSubview(personIcon)
        self.checkScrollView.addSubview(checkStackView)
        self.view.addSubview(checkScrollView)
        
        //spacing
        let Spacing = UIView()
        Spacing.backgroundColor = .cGray
        self.view.addSubview(Spacing)
        
        self.view.addSubview(logoutBtn)
        self.view.addSubview(onboardingBtn)
        self.view.addSubview(loadingIndicator)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(self.view.frame.height / 9)
            make.height.equalTo(40)
        }
        headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalToSuperview().offset(0)
            make.height.equalToSuperview().dividedBy(4.5)
        }
        personIcon.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.width.equalTo(150)
            make.center.equalToSuperview().offset(-50)
        }
        checkScrollView.snp.makeConstraints { make in
            make.top.equalTo(personIcon.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        checkStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(30)
            make.width.equalTo(checkScrollView.snp.width).offset(70)
        }
        Spacing.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(checkScrollView.snp.bottom).offset(30)
            make.height.equalTo(1)
        }
        onboardingBtn.snp.makeConstraints { make in
            make.top.equalTo(Spacing.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        logoutBtn.snp.makeConstraints { make in
            make.top.equalTo(onboardingBtn.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(20)
            make.center.equalToSuperview()
        }
    }
    private func addCheckStack(onboardList : [String]) {
        for onboard in onboardList {
            let label = UILabel()
            label.text = onboard
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 12)
            label.layer.cornerRadius = 10
            label.layer.masksToBounds = true
            label.textAlignment = .center
            label.backgroundColor = .PrimaryColor2
            label.snp.makeConstraints { make in
                make.width.equalTo(70)
            }
            checkStackView.addArrangedSubview(label)
        }
    }
}
//MARK: - UI Actions
extension MyPageViewController {
    @objc func logoutBtnTapped() {
        LogoutService.requestLogout()
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    @objc func onboardingBtnTapped() {
        self.navigationController?.pushViewController(IncomeViewController(), animated: true)
    }
    //데이터 fetch
    public func fetchHashTag() {
        self.loadingIndicator.startAnimating()
        HashtagService.requestTag{ result in
            self.addCheckStack(onboardList: ["\(result.grade)학년", result.major, "\(result.ranking)분위", result.region_city_country_district, result.region_city_province])
            self.loadingIndicator.stopAnimating()
        } onError: { error in
            self.loadingIndicator.stopAnimating()
            print("Error fetching scholarships: \(error)")
        }
    }
}
