//
//  HomeMiddleCell.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import UIKit
import SnapKit
import NVActivityIndicatorView
protocol HomeMiddleCellDelegate: AnyObject {
    func didMiddleLogout()
}
class HomeMiddleCell: UITableViewCell {
    private let firstTableViewDataSource = mainSupportTableViewDataSource()
    private let firstTableViewDelegate = mainSupportTableViewDelegate()
    weak var delegate: HomeMiddleCellDelegate?
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
        view.isScrollEnabled = false
        view.clipsToBounds = true
        view.register(MiddleTableViewCell.self, forCellReuseIdentifier: "Cell")
        return view
    }()
    private let errormessage : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.clipsToBounds = true
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    //로딩인디케이터
    private let loadingIndicator :  NVActivityIndicatorView = {
        let view = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20), type: .ballRotateChase, color: .lightGray, padding: 0)
        view.clipsToBounds = true
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
        view.addSubview(errormessage)
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
        errormessage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.center.equalToSuperview().offset(50)
            make.height.equalTo(30)
        }
    }
}
//MARK: - Actioins
extension HomeMiddleCell {
    private func logoutDelegate() {
        delegate?.didMiddleLogout()
    }
    public func setTable() {
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
            self.loadingIndicator.stopAnimating()
            let errorcode = ExpressionService.requestExpression(errorMessage: error.localizedDescription)
            if errorcode == "404" {
                self.errormessage.text = "추천 장학금이 없습니다⚠️"
                self.loadingIndicator.stopAnimating()
            }else{
                self.loadingIndicator.stopAnimating()
                LogoutService.requestLogout()
                self.logoutDelegate()
            }
            print("Error fetching scholarships: \(error)")
        })
    }
}
