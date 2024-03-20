//
//  DocumentDetailTableViewCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/19.
//
import Foundation
import UIKit
import SnapKit
protocol DocumentDetailTableViewCellDelegate: AnyObject {
    func didTapButton(in cell: DocumentDetailTableViewCell)
}
class DocumentDetailTableViewCell: UITableViewCell {
    weak var delegate: DocumentDetailTableViewCellDelegate?
    //버튼을 담을 뷰
    private let BtnView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    public lazy var consonantBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("가족관계 공공데이터 증명서", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.titleLabel?.textAlignment = .left
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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
//MARK: - UI Layout
extension DocumentDetailTableViewCell {
    private func setLayout() {
        let view = self.contentView
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        BtnView.addSubview(consonantBtn)
        view.addSubview(BtnView)
        view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.bottom.equalToSuperview().inset(5)
        }
        consonantBtn.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(0)
        }
        BtnView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}
//MARK: - Action
extension DocumentDetailTableViewCell {
    @objc private func buttonTapped() {
        delegate?.didTapButton(in: self)
    }
}
