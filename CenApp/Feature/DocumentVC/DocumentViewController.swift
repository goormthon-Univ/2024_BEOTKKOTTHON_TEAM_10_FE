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
    //카테고리 리스트
    static let documentCategories = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    private let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    //재로드 refresh
    private lazy var refreshIndicator : UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .cGray
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
        view.backgroundColor = .PrimaryColor2
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
        self.view.backgroundColor = .PrimaryColor2
        self.navigationController?.navigationBar.backgroundColor = .white
        //헤더
        self.headerView.addSubview(titleLabel)
        self.headerView.addSubview(loadingIndicator)
        
        self.view.addSubview(headerView)
        
        //테이블
        self.documentTableView.addSubview(refreshIndicator)
        self.view.addSubview(documentTableView)
        //카테고리
        createCategoryButtons()
        self.view.addSubview(categoryStackView)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(self.view.frame.height / 9)
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
        categoryStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.height.equalTo(470)
            make.width.equalTo(20)
        }
    }
    private func createCategoryButtons() {
        for (index, category) in DocumentViewController.documentCategories.enumerated() {
            let button = UIButton()
            button.setTitle(category, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
            button.tag = index
            button.backgroundColor = .PrimaryColor2
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            categoryStackView.addArrangedSubview(button)
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
    @objc func categoryButtonTapped(_ sender: UIButton) {
        let categoryIndex = sender.tag
        scrollToCategory(categoryIndex)
    }
    func scrollToCategory(_ categoryIndex: Int) {
        let indexPath = IndexPath(row: 0, section: categoryIndex)
        documentTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
