//
//  ViewController.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/16.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, HomeHeaderCellDelegate, HomeFooterCellDelegate, HomeMiddleCellDelegate {
    //MARK: - UIComponent
    //재로드 refresh
    private lazy var refreshIndicator : UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .cGray
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return control
    }()
    private lazy var mainIcon : UIBarButtonItem = {
        let view = UIBarButtonItem(image: UIImage(named: "mainIcon"), style: .plain, target: self, action: nil)
        view.tintColor = .PrimaryColor
        return view
    }()
    //검색 버튼
    private lazy var settingBtn : UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingBtnTapped))
        btn.tintColor = .gray
        return btn
    }()
    //알림 버튼
    private lazy var alertBtn : UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: nil)
        btn.tintColor = .gray
        return btn
    }()
    //상세 페이지 테이블
    private let tableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.register(HomeHeaderCell.self, forCellReuseIdentifier: "FirstCell")
        view.register(HomeMiddleCell.self, forCellReuseIdentifier: "SecondCell")
        view.register(HomeFooterCell.self, forCellReuseIdentifier: "ThirdCell")
        view.isScrollEnabled = true
        view.clipsToBounds = true
        view.allowsSelection = false
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = .black
    }
}
//MARK: - setLayout
extension HomeViewController {
    private func setLayout() {
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = mainIcon
        self.navigationItem.rightBarButtonItems = [settingBtn, alertBtn]
        self.navigationController?.navigationBar.backgroundColor = .white
        self.tableView.addSubview(refreshIndicator)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(0)
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }
}
//MARK: - setTableView
extension HomeViewController {
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 370
        case 1:
            return 250
        case 2:
            return 350
        default:
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as? HomeHeaderCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as? HomeMiddleCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdCell", for: indexPath) as? HomeFooterCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        }
    }
}
// MARK: - Actions
extension HomeViewController {
    @objc private func settingBtnTapped() {
        self.navigationController?.pushViewController(MyPageViewController(), animated: true)
    }
    @objc private func refreshData() {
        refreshIndicator.endRefreshing()
        setTableView()
        // 첫 번째 셀 초기화와 재설정
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? HomeHeaderCell {
            cell.delegate = self
            cell.AmountData()
        }
        // 두 번째 셀 초기화와 재설정
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? HomeMiddleCell {
            cell.fetchData()
            cell.setTable()
        }
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? HomeFooterCell {
            cell.delegate = self
            cell.fetchData()
            cell.setTable()
        }
        tableView.reloadData()
    }
    func didTapAnnouncementButton() {
        let announcementVC = AnnoucementViewController(order: "마감순")
        navigationController?.pushViewController(announcementVC, animated: true)
    }
    func didTapNewAnnouncementButton() {
        let announcementVC = AnnoucementViewController(order: "최신순")
        navigationController?.pushViewController(announcementVC, animated: true)
    }
    func didFooterLogout() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    func didMiddleLogout() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}
