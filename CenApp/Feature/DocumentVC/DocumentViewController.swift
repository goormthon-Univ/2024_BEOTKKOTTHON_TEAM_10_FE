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
import NVActivityIndicatorView
class DocumentViewController : UIViewController {
    //MARK: - UI Component
    private var documents = DocumentServiceModel(ㄱ: [], ㄷ: [], ㅈ: [], ㅎ: [])
    //카테고리 리스트
    static let documentCategories = ["ㄱ", "ㄷ", "ㅈ", "ㅎ"]
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
    private let errormessage : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.clipsToBounds = true
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
        fetch()
    }
}
//MARK: - UI Layout
extension DocumentViewController {
    private func setLayout() {
        self.view.backgroundColor = .PrimaryColor2
        self.navigationController?.navigationBar.backgroundColor = .white
        self.view.clipsToBounds = true
        self.loadingIndicator.startAnimating()
        //헤더
        self.headerView.addSubview(titleLabel)
        self.headerView.addSubview(loadingIndicator)
        
        self.view.addSubview(headerView)
        
        //테이블
        self.documentTableView.addSubview(refreshIndicator)
        self.view.addSubview(documentTableView)
        //카테고리
        createCategoryButtons()
        let View = UIView()
        View.backgroundColor = .PrimaryColor2
        self.view.addSubview(categoryStackView)
        self.view.addSubview(View)
        self.view.addSubview(errormessage)
        
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
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalTo(headerView.snp.bottom).offset(0)
            make.bottom.equalToSuperview().offset(-self.view.frame.height / 7)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-10)
        }
        categoryStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.height.equalTo(140)
            make.width.equalTo(20)
        }
        errormessage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.center.equalToSuperview()
            make.height.equalTo(30)
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
extension DocumentViewController : UITableViewDelegate, UITableViewDataSource, DocumentCellDelegate, BottomSheetDismissDelegate{
    @objc private func refreshData() {
        refreshIndicator.endRefreshing()
        setTableView()
        fetch()
    }
    private func setTableView() {
        documentTableView.delegate = self
        documentTableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell", for: indexPath) as! DocumentTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .PrimaryColor2
        cell.delegate = self
        switch indexPath.row {
        case 0:
            cell.setupCategories(documents: documents.ㄱ)
            cell.consonantLabel.text = "ㄱ"
        case 1:
            cell.setupCategories(documents: documents.ㄷ)
            cell.consonantLabel.text = "ㄷ"
        case 2:
            cell.setupCategories(documents: documents.ㅈ)
            cell.consonantLabel.text = "ㅈ"
        case 3:
            cell.setupCategories(documents: documents.ㅎ)
            cell.consonantLabel.text = "ㅎ"
        default:
            cell.setupCategories(documents: [])
            cell.consonantLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return CGFloat(documents.ㄱ.count) * CGFloat(100)
        case 1:
            return CGFloat(documents.ㄷ.count) * CGFloat(100)
        case 2:
            return CGFloat(documents.ㅈ.count) * CGFloat(100)
        case 3:
            return CGFloat(documents.ㅎ.count) * CGFloat(100)
        default:
            break
        }
        return 200
    }
    func didTapBtn(in cell: DocumentTableViewCell, atIndex index: Int) {
        if let label = cell.BtnStack.arrangedSubviews[index].subviews.compactMap({ $0 as? UILabel }).first {
            label.textColor = .PrimaryColor
            if let title = label.text,
               let siteText = cell.BtnStack.arrangedSubviews[index].subviews.compactMap({ $0 as? UITextField }).first {
                let site = siteText.text
                showSheet(Info: Document(id: 0, title: title, site: site))
            }
        }
    }
    func bottomSheetDismissed() {
        for cell in documentTableView.visibleCells {
            if let documentCell = cell as? DocumentTableViewCell {
                for subview in documentCell.BtnStack.arrangedSubviews {
                    if let label = subview.subviews.compactMap({ $0 as? UILabel }).first {
                        label.textColor = .black
                    }
                }
            }
        }
    }
}
//MARK: - Actions
extension DocumentViewController{
    @objc func categoryButtonTapped(_ sender: UIButton) {
        let categoryIndex = sender.tag
        scrollToCategory(categoryIndex)
    }
    func scrollToCategory(_ categoryIndex: Int) {
        let indexPath = IndexPath(row: categoryIndex, section: 0)
        documentTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    func showSheet(Info : Document) {
        let viewControllerToPresent = BottomSheetViewController(Info: Info)
        viewControllerToPresent.dismissDelegate = self
        let detentIdentifier =  UISheetPresentationController.Detent.Identifier("customDetent")
        let customDetent = UISheetPresentationController.Detent.custom(identifier: detentIdentifier) { _ in
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let safeAreaBottom = windowScene?.windows.first?.safeAreaInsets.bottom ?? 0
            return 300 - safeAreaBottom
        }
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [customDetent]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    private func fetch() {
        self.loadingIndicator.startAnimating()
        DocumentService.requestDocument(completion: { [weak self] documents in
            guard let self = self, let documents = documents else { return }
            self.documents = documents
            DispatchQueue.main.async {
                self.documentTableView.reloadData() // 테이블 뷰 데이터 리로드
                self.loadingIndicator.stopAnimating()
            }
        }, onError: { error in
            let errorcode = ExpressionService.requestExpression(errorMessage: error.localizedDescription)
            if errorcode == "404" {
                self.errormessage.text = "추천 장학금이 없습니다⚠️"
                self.loadingIndicator.stopAnimating()
            }else{
                self.loadingIndicator.stopAnimating()
                LogoutService.requestLogout()
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
            print("Error fetching scholarships: \(error)")
        })
    }
}
