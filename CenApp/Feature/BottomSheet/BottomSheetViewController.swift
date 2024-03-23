//
//  BottomSheetViewController.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/20.
//

import Foundation
import UIKit
import SnapKit
protocol BottomSheetDismissDelegate: AnyObject {
    func bottomSheetDismissed()
}
class BottomSheetViewController : UIViewController {
    weak var dismissDelegate: BottomSheetDismissDelegate?
    var Info : Document
    init(Info : Document) {
        self.Info = Info
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //서류이름
    public let titleLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.textAlignment = .left
        return label
    }()
    //서류 URL로 가기
    private lazy var urlBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .PrimaryColor
        btn.setTitle("서류 URL로 이동하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(supportBtnTapped), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setValue()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            dismissDelegate?.bottomSheetDismissed()
        }
    }
}
//MARK: - UI Layout
extension BottomSheetViewController {
    private func setLayout() {
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        self.view.addSubview(titleLabel)
        self.view.addSubview(urlBtn)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(70)
            make.height.equalTo(30)
        }
        urlBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(titleLabel.snp.bottom).offset(80)
            make.height.equalTo(50)
        }
    }
}
//MARK: - Actions
extension BottomSheetViewController {
    private func setValue() {
        self.titleLabel.text = Info.title
    }
    @objc private func supportBtnTapped() {
        if let postSite = Info.site {
            if let url = URL(string: postSite) {
                UIApplication.shared.open(url)
            }else { print("존재하지 않는 url") }
        }else{ print("존재하지 않는 url") }
    }
}
