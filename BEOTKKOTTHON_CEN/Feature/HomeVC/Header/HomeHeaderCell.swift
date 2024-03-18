//
//  HomeHeaderCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import UIKit
import SnapKit

protocol HomeHeaderCellDelegate: AnyObject {
    func didTapAnnouncementButton()
}
class HomeHeaderCell: UITableViewCell {
    weak var delegate: HomeHeaderCellDelegate?
    //버튼 처리
    var announcementButtonAction: (() -> Void)?
    private let mainIcon : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "mainIcon")
        return view
    }()
    //검색 버튼
    private lazy var searchBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        btn.tintColor = .gray
        return btn
    }()
    //알림 버튼
    private lazy var alertBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setImage(UIImage(named: "bell"), for: .normal)
        return btn
    }()
    //장학금 이미지
    private let headerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let scholarshipImage : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.image = UIImage(named: "mainScholarship")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    //장학금 수령액
    private let scholarshipAmount : UITextView = {
        let view = UITextView()
        let attributedText = NSMutableAttributedString()
        
        let firstPart = NSAttributedString(string: "지금 신청만 하면", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)
        ])
        let secondPart = NSAttributedString(string: "\n365만원", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.PrimaryColor,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)
        ])
        let thirdPart = NSAttributedString(string: "을\n받을 수 있어요", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)
        ])
        attributedText.append(firstPart)
        attributedText.append(secondPart)
        attributedText.append(thirdPart)
        view.isEditable = false
        view.isScrollEnabled = false
        view.attributedText = attributedText
        view.backgroundColor = .clear
        view.textAlignment = .left
        view.clipsToBounds = true
        return view
    }()
    //공고 버튼
    private lazy var announcementBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
        btn.setTitle("이번 달 공고 보러가기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(announcementBtnTapped), for: .touchUpInside)
        return btn
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
extension HomeHeaderCell {
    private func setLayout() {
        let view = self.contentView
        view.backgroundColor = .white
        view.addSubview(mainIcon)
        view.addSubview(alertBtn)
        view.addSubview(searchBtn)
        view.addSubview(scholarshipImage)
        view.addSubview(scholarshipAmount)
        view.addSubview(announcementBtn)
        
        
        mainIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(0)
            make.width.height.equalTo(50)
            make.leading.equalToSuperview().inset(20)
        }
        alertBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        searchBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.trailing.equalTo(alertBtn.snp.leading).offset(-20)
            make.width.height.equalTo(24)
        }
        scholarshipImage.snp.makeConstraints { make in
            make.top.equalTo(mainIcon.snp.bottom).offset(0)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalToSuperview()
        }
        scholarshipAmount.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(scholarshipImage.snp.top).offset(50)
            make.height.equalTo(155)
            make.width.equalTo(232)
        }
        announcementBtn.snp.makeConstraints { make in
            make.bottom.equalTo(scholarshipImage.snp.bottom).offset(-75)
            make.leading.equalToSuperview().inset(25)
            make.width.equalTo(170)
            make.height.equalTo(50)
        }
    }
}
//MARK: - Action
extension HomeHeaderCell {
    @objc private func announcementBtnTapped() {
        delegate?.didTapAnnouncementButton()
    }
}
