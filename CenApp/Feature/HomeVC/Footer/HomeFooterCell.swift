//
//  HomeFooterCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import UIKit
import SnapKit
protocol HomeFooterCellDelegate: AnyObject {
    func didTapNewAnnouncementButton()
    func didFooterLogout()
}
class HomeFooterCell: UITableViewCell {
    private let secondTableViewDataSource = newAnnoucementTableViewDataSource()
    private let secondTableViewDelegate = newAnnoucementTableViewDelegate()
    weak var delegate: HomeFooterCellDelegate?
    private let checkLaebl : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "새로운 공고를 확인해보세요"
        label.textColor = .black
        return label
    }()
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
    //장학금 공고 이동
    private lazy var moveToAnnouncement : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(announcementBtnTapped), for: .touchUpInside)
        return btn
    }()
    //장학금 테이블
    public let checkTableView : UITableView = {
        let view = UITableView()
        view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.register(BottomTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.isScrollEnabled = true
        view.clipsToBounds = true
        return view
    }()
    private let errormessage : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.clipsToBounds = true
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setTable()
        fetchData()
        fetchHashTag()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Layout
extension HomeFooterCell {
    public func setTable() {
        checkTableView.delegate = secondTableViewDelegate
        checkTableView.dataSource = secondTableViewDataSource
    }
    private func setLayout() {
        let view = self.contentView
        self.checkTableView.delegate = secondTableViewDelegate
        self.checkTableView.dataSource = secondTableViewDataSource
        view.addSubview(checkLaebl)
        self.checkScrollView.addSubview(checkStackView)
        view.addSubview(checkScrollView)
        view.addSubview(moveToAnnouncement)
        let View = UIView()
        View.backgroundColor = .white
        View.addSubview(checkTableView)
        view.addSubview(View)
        view.addSubview(errormessage)
        checkLaebl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(30)
        }
        checkScrollView.snp.makeConstraints { make in
            make.top.equalTo(checkLaebl.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        checkStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(30)
            make.width.equalTo(checkScrollView.snp.width).offset(70)
        }
        moveToAnnouncement.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(30)
            make.width.height.equalTo(20)
        }
        View.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalTo(checkScrollView.snp.bottom).offset(60)
            make.height.equalTo(310)
        }
        checkTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(-30)
            make.height.equalTo(view.frame.width)
            make.width.equalTo(view.frame.height)
        }
        errormessage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.center.equalToSuperview()
            make.height.equalTo(30)
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

//MARK: - Action
extension HomeFooterCell {
    @objc private func announcementBtnTapped() {
        delegate?.didTapNewAnnouncementButton()
    }
    private func logoutDelegate() {
        delegate?.didFooterLogout()
    }
    //데이터 fetch
    public func fetchHashTag() {
        HashtagService.requestTag{ result in
            self.addCheckStack(onboardList: ["\(result.grade)학년", result.major, "\(result.ranking)분위", result.region_city_country_district, result.region_city_province])
        } onError: { error in
            print("Error fetching scholarships: \(error)")
        }
    }
    public func fetchData() {
        AnnoucementService.scholarshipNew(completion: { [weak self] scholarships in
            guard let self = self, let scholarships = scholarships else { return }
            self.secondTableViewDelegate.scholarships = scholarships
            self.secondTableViewDataSource.scholarships = scholarships
            DispatchQueue.main.async {
                self.checkTableView.reloadData() // 테이블 뷰 데이터 리로드
            }
        }, onError: { error in
            let errorcode = ExpressionService.requestExpression(errorMessage: error.localizedDescription)
            if errorcode == "404" {
                self.errormessage.text = "추천 장학금이 없습니다⚠️"
            }else{
//                LogoutService.requestLogout()
//                self.logoutDelegate()
            }
            print("Error fetching scholarships: \(error)")
        })
    }
}
