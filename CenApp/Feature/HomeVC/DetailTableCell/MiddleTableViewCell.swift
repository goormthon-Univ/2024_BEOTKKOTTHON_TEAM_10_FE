//
//  MiddleTableViewCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/17.
//

import Foundation
import UIKit
import SnapKit
class MiddleTableViewCell: UITableViewCell {
    private let image : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.image = UIImage(named: "middle")
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let titleLabel: UITextField = {
        let view = UITextField()
        view.textColor = .black
        view.text = "강북구 꿈나무키움 장학"
        view.backgroundColor = .clear
        view.font = UIFont.systemFont(ofSize: 15)
        view.textAlignment = .left
        view.isEnabled = false
        return view
    }()
    private let dayLabel : UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "D-1"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
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
        view.addSubview(image)
        view.addSubview(titleLabel)
        view.addSubview(dayLabel)
        image.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
            make.width.height.equalTo(20)
        }
        dayLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(15)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(image.snp.trailing).offset(10)
            make.trailing.equalTo(dayLabel.snp.leading).offset(-10)
            make.height.equalTo(30)
        }
    }
}
