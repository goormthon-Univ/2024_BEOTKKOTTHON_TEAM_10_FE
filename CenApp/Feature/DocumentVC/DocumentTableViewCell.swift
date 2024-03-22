//
//  DocumentTableViewCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/19.
//

import Foundation
import UIKit
import SnapKit
protocol DocumentCellDelegate : AnyObject {
    func didTapBtn(in cell: DocumentTableViewCell, atIndex index: Int)
}
class DocumentTableViewCell: UITableViewCell{
    weak var delegate: DocumentCellDelegate?
    private var index: Int = 0
    //버튼을 추가
    public let Categories : [String] = ["공인인증서", "가족관계증명서", "기초생활수급 증명서"]
    //ㄱ,ㄴ,ㄷ...순
    public let consonantLabel : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "ㄱ"
        label.textAlignment = .left
        label.backgroundColor = .PrimaryColor2
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.layer.masksToBounds = true
        return label
    }()
    //버튼들을 담을 스택
    public let BtnStack : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.backgroundColor = .PrimaryColor2
        view.distribution = .fill
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
extension DocumentTableViewCell {
    private func setLayout() {
        let view = self.contentView
        view.backgroundColor = .PrimaryColor2
        view.addSubview(consonantLabel)
        AddBtnStack()
        view.addSubview(BtnStack)
        view.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(0)
        }
        consonantLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        BtnStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalToSuperview().inset(60)
            make.top.equalTo(consonantLabel.snp.bottom).offset(10)
            make.height.equalTo(CGFloat(Categories.count) * CGFloat(62))
        }
    }
    private func AddBtnStack() {
        for (index, cell) in Categories.enumerated() {
            //버튼을 담을 뷰
            let View = UIView()
            View.backgroundColor = .white
            View.layer.cornerRadius = 10
            View.layer.masksToBounds = true
            //버튼
            let Btn = UIButton()
            Btn.backgroundColor = .clear
            Btn.clipsToBounds = true
            Btn.addTarget(self, action: #selector(BtnTapped), for: .touchUpInside)
            //label
            let label = UILabel()
            label.backgroundColor = .clear
            label.text = cell
            label.textAlignment = .left
            label.font = UIFont.boldSystemFont(ofSize: 15)
            
            self.index = index
            View.addSubview(Btn)
            View.addSubview(label)
            BtnStack.addArrangedSubview(View)
            View.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(0)
                make.height.equalTo(55)
            }
            Btn.snp.makeConstraints { make in
                make.leading.trailing.top.bottom.equalToSuperview().inset(0)
            }
            label.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(0)
                make.leading.trailing.equalToSuperview().inset(20)
            }
        }
    }
}
//MARK: - Actions
extension DocumentTableViewCell {
    @objc private func BtnTapped(sender: UIButton) {
        if let index = BtnStack.arrangedSubviews.firstIndex(of: sender.superview!) {
            delegate?.didTapBtn(in: self, atIndex: index)
        }
    }
}
