//
//  DocumentTableViewCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/19.
//

import Foundation
import UIKit
import SnapKit
class DocumentTableViewCell: UITableViewCell {
    private let consonantLabel : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "ㄱ"
        label.textAlignment = .left
        label.backgroundColor = .SecondaryColor
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
    private let titleText: UITextView = {
        let label = UITextView()
        label.textColor = .black
        label.text = "가족관계증명서"
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.isEditable = false
        label.isScrollEnabled = false
        return label
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
extension DocumentTableViewCell {
    private func setLayout() {
        let view = self.contentView
        view.backgroundColor = .SecondaryColor
        view.addSubview(consonantLabel)
        totalView.addSubview(titleText)
        view.addSubview(totalView)
        
        view.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(0)
        }
        consonantLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        titleText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.center.equalToSuperview()
        }
        totalView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(60)
            make.top.equalTo(consonantLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(0)
        }
    }
}
