//
//  BottomTopCollectionCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/17.
//

import Foundation
import UIKit
import SnapKit

class BottomTableViewCell: UITableViewCell {
    private let totalView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.customGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.text = "성적장학금"
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 20)
        label.backgroundColor = .white
        return label
    }()
    private let subLabel : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "한국장학재단"
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = .white
        return label
    }()
    private let tagLabel1 : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "#서울"
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.backgroundColor = .SecondaryColor
        return label
    }()
    private let tagLabel2 : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "#강북구"
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.backgroundColor = .SecondaryColor
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
        view.backgroundColor = .white
        totalView.addSubview(titleLabel)
        totalView.addSubview(subLabel)
        totalView.addSubview(tagLabel1)
        totalView.addSubview(tagLabel2)
        view.addSubview(totalView)
        view.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(250)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(30)
        }
        totalView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(30)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        subLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        tagLabel1.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(20)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        tagLabel2.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(20)
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.leading.equalTo(tagLabel1.snp.trailing).offset(10)
        }
    }
}
