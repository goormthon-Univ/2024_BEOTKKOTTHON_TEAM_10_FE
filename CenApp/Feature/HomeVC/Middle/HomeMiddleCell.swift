//
//  HomeMiddleCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import UIKit
import SnapKit
class HomeMiddleCell: UITableViewCell {
    private let firstTableViewDataSource = mainSupportTableViewDataSource()
    private let firstTableViewDelegate = mainSupportTableViewDelegate()
    private let supportLaebl : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "놓치지 말고 지원하세요!"
        label.textColor = .black
        label.clipsToBounds = true
        return label
    }()
    //테이블 뷰
    private let middleTableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .PrimaryColor2
        view.isEditing = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.separatorStyle = .none
        view.allowsSelection = false
        view.isScrollEnabled = false
        view.clipsToBounds = true
        view.register(MiddleTableViewCell.self, forCellReuseIdentifier: "Cell")
        return view
    }()
    //로딩인디케이터
    private let loadingIndicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .gray
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setTable()
        fetchData()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - setLayout
extension HomeMiddleCell {
    private func setLayout() {
        let view = self.contentView
        self.middleTableView.delegate = firstTableViewDelegate
        self.middleTableView.dataSource = firstTableViewDataSource
        view.addSubview(supportLaebl)
        view.addSubview(middleTableView)
        view.addSubview(loadingIndicator)
        supportLaebl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
            make.top.equalTo(50)
        }
        middleTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(supportLaebl.snp.bottom).offset(20)
            make.height.equalTo(160)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.center.equalToSuperview()
            make.height.equalTo(30)
        }
    }
}
//MARK: - Actioins
extension HomeMiddleCell {
    private func setTable() {
        middleTableView.dataSource = firstTableViewDataSource
        middleTableView.delegate = firstTableViewDelegate
    }
    public func fetchData() {
        self.loadingIndicator.startAnimating()
        AnnoucementService.scholarshipDay(completion: { [weak self] scholarships in
            guard let self = self, let scholarships = scholarships else { return }
            self.firstTableViewDelegate.scholarships = scholarships
            self.firstTableViewDataSource.scholarships = scholarships
            DispatchQueue.main.async {
                self.middleTableView.reloadData() // 테이블 뷰 데이터 리로드
                self.loadingIndicator.stopAnimating()
            }
        }, onError: { error in
            print("Error fetching scholarships: \(error)")
            self.loadingIndicator.stopAnimating()
        })
    }
}
