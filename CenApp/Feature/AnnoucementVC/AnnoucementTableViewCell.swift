//
//  AnnoucementTableViewCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import UIKit
import SnapKit
class AnnoucementTableViewCell: UITableViewCell {
    public let dayLabel : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = ""
        label.textAlignment = .left
        label.backgroundColor = .PrimaryColor2
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.layer.masksToBounds = true
        return label
    }()
    //전체 뷰
    private let totalView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    public let companyLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = ""
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    public let titleText: UITextView = {
        let label = UITextView()
        label.textColor = .black
        label.text = ""
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.isEditable = false
        label.isUserInteractionEnabled = false
        label.isScrollEnabled = false
        return label
    }()
    public let deadlineLabel : UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = ""
        label.textAlignment = .center
        label.backgroundColor = .cLightGray
        label.layer.cornerRadius = 5
        label.font = UIFont.systemFont(ofSize: 13)
        label.layer.masksToBounds = true
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setLayout() {
        let view = self.contentView
        view.backgroundColor = .PrimaryColor2
        view.addSubview(dayLabel)
        totalView.addSubview(companyLabel)
        totalView.addSubview(titleText)
        totalView.addSubview(deadlineLabel)
        view.addSubview(totalView)
        
        view.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(0)
        }
        dayLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        companyLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(20)
            make.height.equalTo(15)
            make.width.equalToSuperview().dividedBy(2)
        }
        titleText.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(companyLabel.snp.bottom).offset(10)
            make.width.equalToSuperview().dividedBy(1.5)
            make.bottom.equalToSuperview().inset(10)
        }
        deadlineLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        totalView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(dayLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
