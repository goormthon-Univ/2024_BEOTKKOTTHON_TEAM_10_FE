//
//  DocumentTableViewCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/19.
//

import Foundation
import UIKit
import SnapKit
class DocumentTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    private let consonantLabel : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "ㄱ"
        label.textAlignment = .left
        label.backgroundColor = .PrimaryColor2
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.layer.masksToBounds = true
        return label
    }()
    //테이블 뷰
    private let detailTableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .PrimaryColor2
        view.isEditing = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.separatorStyle = .none
        view.allowsSelection = false
        view.isScrollEnabled = false
        view.register(DocumentDetailTableViewCell.self, forCellReuseIdentifier: "Cell")
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
        detailTableView.delegate = self
        detailTableView.dataSource = self
        view.addSubview(detailTableView)
        
        view.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(0)
        }
        consonantLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        detailTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(50)
            make.top.equalTo(consonantLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(0)
        }
    }
}
//MARK: - TableViewDelegate, TableViewDatasource
extension DocumentTableViewCell {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell", for: indexPath) as! DocumentDetailTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .PrimaryColor2
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
