//
//  AnnoucementHeaderCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import UIKit
import SnapKit
class AnnoucementHeaderCell: UITableViewCell, UITextViewDelegate {
    private let titleLabel : UITextView = {
        let label = UITextView()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "우아한 사장님 자녀 장학금 지원 대학생 일반 장학생 모집"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        label.isScrollEnabled = false
        return label
    }()
    //해시테그
    private let tagScrollView : UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.clipsToBounds = true
        return view
    }()
    private let tagStackView : UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fill
        return view
    }()
    private let subLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "(주)우아한 청년들"
        label.textColor = .gray
        label.textAlignment = .left
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()
    private let spcaing : UIView = {
        let view = UIView()
        view.backgroundColor = .cGray
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
//MARK: - UI Layout
extension AnnoucementHeaderCell {
    private func setLayout() {
        let view = self.contentView
        view.backgroundColor = .white
        self.addtagStack()
        titleLabel.delegate = self
        self.tagScrollView.addSubview(tagStackView)
        view.addSubview(tagScrollView)
        view.addSubview(titleLabel)
        view.addSubview(subLabel)
        view.addSubview(spcaing)
        
        tagScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        tagStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(30)
            make.width.equalTo(tagScrollView.snp.width).offset(70)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(tagScrollView.snp.bottom).offset(30)
        }
        subLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        spcaing.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(1)
        }
    }
    private func addtagStack() {
        let onboardList = ["#7분위", "#공학계열", "#4학년", "#서울", "#강북구"]
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
            tagStackView.addArrangedSubview(label)
        }
    }
}
//MARK: - TextViewDelegate
extension AnnoucementHeaderCell {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: self.contentView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if estimatedSize.height <= 180 {}else {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
}
//MARK: - UI Action
extension AnnoucementHeaderCell {
    
}
