//
//  AnnoucementMiddleCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/19.
//

import Foundation
import UIKit
import SnapKit
class AnnoucementMiddleCell: UITableViewCell, UITextViewDelegate {
    //지원 기간
    private let periodLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "지원기간"
        label.textColor = .gray
        label.textAlignment = .left
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()
    private let periodText : UITextView = {
        let label = UITextView()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "2024년 03월 13일 ~ 03월 20일"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        label.isScrollEnabled = false
        return label
    }()
    //지원 대상
    private let targetLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "지원대상"
        label.textColor = .gray
        label.textAlignment = .left
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()
    private let targetText : UITextView = {
        let label = UITextView()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "대학교/전문대학 3학기 또는 4학기 재학생 중 IT 또는 게임 분야 진로 희망자. 인문, 사회과학, 자연, 공학 등 소속 전공 구분 없이 선발"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        label.isScrollEnabled = false
        return label
    }()
    //지원 금액
    private let amountLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "지원금액"
        label.textColor = .gray
        label.textAlignment = .left
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()
    private let amountText : UITextView = {
        let label = UITextView()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "학기당 생활지원금 500만원(1인 연간 최대 1000만원 지원) 정규학기 기준 최대 3년 간 지원"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        label.isScrollEnabled = false
        return label
    }()
    //제출 서류
    private let documentLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "제출서류"
        label.textColor = .gray
        label.textAlignment = .left
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()
    private let documentText : UITextView = {
        let label = UITextView()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "공인인증서"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        label.isScrollEnabled = false
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
extension AnnoucementMiddleCell {
    private func setLayout() {
        let view = self.contentView
        view.backgroundColor = .white
        //지원기간
        periodText.delegate = self
        //지원대상
        targetText.delegate = self
        //지원금액
        amountText.delegate = self
        //제출서류
        documentText.delegate = self
        
        view.addSubview(periodLabel)
        view.addSubview(periodText)
        view.addSubview(targetLabel)
        view.addSubview(targetText)
        view.addSubview(amountLabel)
        view.addSubview(amountText)
        view.addSubview(documentLabel)
        view.addSubview(documentText)
        
        periodLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        periodText.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(periodLabel.snp.trailing).offset(20)
        }
        targetLabel.snp.makeConstraints { make in
            make.top.equalTo(periodText.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        targetText.snp.makeConstraints { make in
            make.top.equalTo(periodText.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(targetLabel.snp.trailing).offset(20)
        }
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(targetText.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        amountText.snp.makeConstraints { make in
            make.top.equalTo(targetText.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(amountLabel.snp.trailing).offset(20)
        }
        documentLabel.snp.makeConstraints { make in
            make.top.equalTo(amountText.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        documentText.snp.makeConstraints { make in
            make.top.equalTo(amountText.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(documentLabel.snp.trailing).offset(20)
        }
    }
}
//MARK: - TextViewDelegate
extension AnnoucementMiddleCell {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: self.contentView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if estimatedSize.height <= 30 {}else {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
}
//MARK: - UI Action
extension AnnoucementMiddleCell {
    
}
