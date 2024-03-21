//
//  HomeHeaderCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
protocol HomeHeaderCellDelegate: AnyObject {
    func didTapAnnouncementButton()
}
class HomeHeaderCell: UITableViewCell {
    weak var delegate: HomeHeaderCellDelegate?
    //버튼 처리
    var announcementButtonAction: (() -> Void)?
    private let scholarshipImage : AnimatedImageView = {
        let view = AnimatedImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
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
        view.addSubview(scholarshipImage)
        view.addSubview(scholarshipAmount)
        view.addSubview(announcementBtn)
        scholarshipImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
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
            make.bottom.equalTo(scholarshipImage.snp.bottom).offset(-50)
            make.leading.equalToSuperview().inset(25)
            make.width.equalTo(170)
            make.height.equalTo(50)
        }
        if let gifUrl = Bundle.main.url(forResource: "mainCoin", withExtension: "gif") {
            scholarshipImage.kf.setImage(with: gifUrl)
        }
    }
}
//MARK: - Action
extension HomeHeaderCell {
    @objc private func announcementBtnTapped() {
        delegate?.didTapAnnouncementButton()
    }
}
