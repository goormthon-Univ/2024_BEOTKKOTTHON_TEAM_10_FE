//
//  DocumentDetailTableViewCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/19.
//
import Foundation
import UIKit
import SnapKit
class DocumentDetailTableViewCell: UITableViewCell {
    private let consonantLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .white
        label.text = "가족관계증명서"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
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
}
//MARK: - UI Layout
extension DocumentDetailTableViewCell {
    private func setLayout() {
        let view = self.contentView
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.addSubview(consonantLabel)
        view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.bottom.equalToSuperview().inset(5)
        }
        consonantLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}
