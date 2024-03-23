//
//  AnnoucementViewController.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import SnapKit
import UIKit
import iOSDropDown
import NVActivityIndicatorView
class AnnoucementViewController : UIViewController, UITableViewDelegate {
    private let annoucentTableViewDelegate = AnnoucementTableViewDelegate()
    private let annoucentTableViewDatasource = AnnoucementTableViewDataSource()
    //이니셜라이저로 받기
    var order : String
    init(order: String) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - UI Component
    //재로드 refresh
    private lazy var refreshIndicator : UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .cGray
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return control
    }()
    //로딩 인디케이터
    private let loadingIndicator :  NVActivityIndicatorView = {
        let view = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20), type: .ballRotateChase, color: .lightGray, padding: 0)
        view.clipsToBounds = true
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
        label.text = "장학금 공고 리스트"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        return label
    }()
    //해시테그
    private let tagScrollView : UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.clipsToBounds = true
        return view
    }()
    private let tagStackView : UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fill
        return view
    }()
    private let subLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "진행 중인 공고"
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()
    //순서 버튼
    private let dropdown = DropDown()
    //장학금 테이블
    private let annoucementTableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .PrimaryColor2
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.register(AnnoucementTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.isScrollEnabled = true
        view.clipsToBounds = true
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
        setupDropdown()
        fetchData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
//MARK: - UI Layout
extension AnnoucementViewController {
    private func setLayout() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        //헤더
        self.headerView.addSubview(titleLabel)
        self.addtagStack()
        self.tagScrollView.addSubview(tagStackView)
        self.headerView.addSubview(tagScrollView)
        self.headerView.addSubview(subLabel)
        self.headerView.addSubview(dropdown)
        self.headerView.addSubview(loadingIndicator)
        
        self.view.addSubview(headerView)
        
        //테이블
        let View = UIView()
        View.backgroundColor = .PrimaryColor2
        self.annoucementTableView.addSubview(refreshIndicator)
        View.addSubview(annoucementTableView)
        self.view.addSubview(View)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(self.view.frame.height / 9)
            make.height.equalTo(40)
        }
        tagScrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        tagStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(30)
            make.width.equalTo(tagScrollView.snp.width).offset(70)
        }
        subLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.width.equalToSuperview().dividedBy(2)
            make.bottom.equalToSuperview().inset(20)
        }
        dropdown.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(15)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalToSuperview().offset(0)
            make.height.equalToSuperview().dividedBy(3)
        }
        annoucementTableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(0)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-10)
        }
        View.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalTo(headerView.snp.bottom).offset(0)
            make.bottom.equalToSuperview().inset(0)
        }
        self.loadingIndicator.startAnimating()
    }
    private func addtagStack() {
        let onboardList = ["#7분위", "#공학계열", "#4학년", "#서울", "#강북구"]
        for onboard in onboardList {
            let label = UILabel()
            label.text = onboard
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 12)
            label.layer.cornerRadius = 10
            label.layer.masksToBounds = true
            label.textAlignment = .center
            label.backgroundColor = .PrimaryColor2
            label.snp.makeConstraints { make in
                make.width.equalTo(70)
            }
            tagStackView.addArrangedSubview(label)
        }
    }
}
//MARK: - TableViewDelegate, TableViewDataSource
extension AnnoucementViewController {
    @objc private func refreshData() {
        refreshIndicator.endRefreshing()
        fetchData()
    }
    private func setTableView() {
        annoucementTableView.delegate = annoucentTableViewDelegate
        annoucementTableView.dataSource = annoucentTableViewDatasource
    }
}
//MARK: - Actions
extension AnnoucementViewController {
    private func setupDropdown() {
        dropdown.optionArray = ["마감순", "최신순"]
        dropdown.isSearchEnable = false
        dropdown.text = order
        dropdown.font = UIFont.systemFont(ofSize: 14)
        dropdown.textColor = UIColor.black
        dropdown.selectedRowColor = UIColor.PrimaryColor
        dropdown.arrowSize = 10
        dropdown.checkMarkEnabled = false
        dropdown.backgroundColor = UIColor.white
        // 선택한 항목에 대한 이벤트 처리
        dropdown.didSelect { (selectedItem, index, id) in
            if index == 0 {
                self.order = "마감순"
                self.fetchData()
            }else if index == 1 {
                self.order = "최신순"
                self.fetchData()
            }
        }
    }
    //데이터 fetch
    private func fetchData() {
        if order == "마감순" {
            AnnoucementService.scholarshipDay(completion: { [weak self] scholarships in
                guard let self = self, let scholarships = scholarships else { return }
                annoucentTableViewDatasource.scholarships = scholarships
                annoucentTableViewDelegate.scholarships = scholarships
                DispatchQueue.main.async {
                    self.annoucementTableView.reloadData() // 테이블 뷰 데이터 리로드
                    self.loadingIndicator.stopAnimating()
                }
            }, onError: { error in
                print("Error fetching scholarships: \(error)")
            })
        } else if order == "최신순" {
            AnnoucementService.scholarshipNew(completion: { [weak self] scholarships in
                guard let self = self, let scholarships = scholarships else { return }
                annoucentTableViewDatasource.scholarships = scholarships
                annoucentTableViewDelegate.scholarships = scholarships
                DispatchQueue.main.async {
                    self.annoucementTableView.reloadData() // 테이블 뷰 데이터 리로드
                    self.loadingIndicator.stopAnimating()
                }
            }, onError: { error in
                print("Error fetching scholarships: \(error)")
            })
        }
    }
}
