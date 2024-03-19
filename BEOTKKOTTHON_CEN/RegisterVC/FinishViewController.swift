//
//  FinishViewController.swift
//  CenApp
//
//  Created by 김민솔 on 3/18/24.
//

import UIKit
import Then
import SnapKit

class FinishViewController: CustomProgressViewController {
    //MARK: -- UI Component
    private let progressLabel = UILabel().then {
        $0.text = "완료"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configUI()
        updateProgressBar(progress: 4/4)
        view.backgroundColor = .white
    }
    func addSubviews() {
        view.addSubview(progressLabel)
    }
    func configUI() {
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.centerX.equalToSuperview()
        }
    }

}
