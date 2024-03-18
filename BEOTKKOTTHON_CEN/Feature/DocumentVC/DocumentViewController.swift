//
//  DocumentViewController.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/19.
//

import Foundation
import SnapKit
import UIKit
import iOSDropDown
class DocumentViewController : UIViewController {
    private let documentTableViewDelegate = DocumentTableViewDelegate()
    private let documentTableViewDatasource = DocumentTableViewDataSource()
    //MARK: - UI Component
    //재로드 refresh
    private lazy var refreshIndicator : UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .customGray
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return control
    }()
    //로딩 인디케이터
    private let loadingIndicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.backgroundColor = .clear
        view.color = .lightGray
        view.style = .large
        return view
    }()
    //상위 뷰
    private let headerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "서류"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        return label
    }()
    //장학금 테이블
    private let documentTableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .SecondaryColor
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.register(DocumentTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.isScrollEnabled = true
        view.clipsToBounds = true
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
    }
}
//MARK: - UI Layout
extension DocumentViewController {
    private func setLayout() {
        self.view.backgroundColor = .SecondaryColor
        self.navigationController?.navigationBar.backgroundColor = .white
        //헤더
        self.headerView.addSubview(titleLabel)
        self.headerView.addSubview(loadingIndicator)
        
        self.view.addSubview(headerView)
        
        //테이블
        self.documentTableView.addSubview(refreshIndicator)
        self.view.addSubview(documentTableView)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(self.view.frame.height / 10)
            make.height.equalTo(40)
        }
        headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalToSuperview().offset(0)
            make.height.equalToSuperview().dividedBy(4.5)
        }
        documentTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(0)
            make.top.equalTo(headerView.snp.bottom).offset(0)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
//MARK: - TableViewDelegate, TableViewDataSource
extension DocumentViewController {
    @objc private func refreshData() {
        refreshIndicator.endRefreshing()
    }
    private func setTableView() {
        documentTableView.delegate = documentTableViewDelegate
        documentTableView.dataSource = documentTableViewDatasource
    }
}
//MARK: - Actions
extension DocumentViewController {
    
}
