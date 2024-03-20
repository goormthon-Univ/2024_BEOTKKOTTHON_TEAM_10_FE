//
//  BottomSheetViewController.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/20.
//

import Foundation
import UIKit
import SnapKit

class BottomSheetViewController : UIViewController {
    //서류이름
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "공인인증서"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.textAlignment = .left
        return label
    }()
    //서류 상세
    private let decLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "KB 국민은행"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    //서류 URL로 가기
    private let urlBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .PrimaryColor
        btn.setTitle("서류 URL로 이동하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
}
//MARK: - UI Layout
extension BottomSheetViewController {
    private func setLayout() {
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        self.view.addSubview(titleLabel)
        self.view.addSubview(decLabel)
        self.view.addSubview(urlBtn)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(30)
        }
        decLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.height.equalTo(20)
        }
        urlBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(decLabel.snp.bottom).offset(50)
            make.height.equalTo(50)
        }
    }
}
