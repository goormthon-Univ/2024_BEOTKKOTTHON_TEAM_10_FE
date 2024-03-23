//
//  AnnoucementFooterCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/19.
//

import Foundation
import UIKit
import SnapKit
class AnnoucementFooterCell: UITableViewCell, UITextViewDelegate {
    //상세정보
    private let infoLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "상세정보"
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()
    public let infoText : UITextView = {
        let label = UITextView()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = ""
        label.textColor = .gray
        label.backgroundColor = .white
        label.textAlignment = .left
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
extension AnnoucementFooterCell {
    private func setLayout() {
        let view = self.contentView
        view.backgroundColor = .white
        infoText.delegate = self
        
        view.addSubview(infoLabel)
        view.addSubview(infoText)
        
        infoLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        infoText.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
//MARK: - TextViewDelegate
extension AnnoucementFooterCell {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: self.contentView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if estimatedSize.height <= 100 {}else {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
}
