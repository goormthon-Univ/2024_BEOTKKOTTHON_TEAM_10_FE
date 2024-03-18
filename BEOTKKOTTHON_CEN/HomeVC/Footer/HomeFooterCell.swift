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
    private let checkTableView : UITableView = {
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Layout
extension HomeFooterCell {
    private func setLayout() {
        let view = self.contentView
        self.checkTableView.delegate = secondTableViewDelegate
        self.checkTableView.dataSource = secondTableViewDataSource
        view.addSubview(checkLaebl)
        self.addCheckStack()
        self.checkScrollView.addSubview(checkStackView)
        view.addSubview(checkScrollView)
        view.addSubview(moveToAnnouncement)
        let View = UIView()
        View.backgroundColor = .white
        View.addSubview(checkTableView)
        view.addSubview(View)
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
            make.top.trailing.equalToSuperview().inset(20)
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
    }
    private func addCheckStack() {
        let onboardList = ["#7분위", "#공학계열", "#4학년", "#서울", "#강북구"]
        for onboard in onboardList {
            let label = UILabel()
            label.text = onboard
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.layer.cornerRadius = 10
            label.layer.masksToBounds = true
            label.textAlignment = .center
            label.backgroundColor = .SecondaryColor
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
}
