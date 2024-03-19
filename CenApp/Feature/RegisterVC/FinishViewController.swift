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
        $0.text = "완료!"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    private let finishImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "Frame")
    }
    private let finishLabel = UILabel().then {
        $0.text = "저장 완료!"
        $0.textColor = UIColor.PrimaryColor
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 24)
    }
    private let alramLabel = UILabel().then {
        $0.text = "조건에 맞는 장학금이\n 올라오면 알려드릴게요"
        $0.numberOfLines = 0
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configUI()
        updateProgressBar(progress: 4/4)
        view.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let tabViewController = TabViewController()
            UIApplication.shared.windows.first?.rootViewController = tabViewController
        }
    }
    func addSubviews() {
        view.addSubview(progressLabel)
        view.addSubview(finishImageView)
        view.addSubview(finishLabel)
        view.addSubview(alramLabel)
        
    }
    func configUI() {
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.centerX.equalToSuperview()
        }
        finishImageView.snp.makeConstraints {
            $0.top.equalTo(progressLabel.snp.bottom).offset(70)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        finishLabel.snp.makeConstraints {
            $0.top.equalTo(finishImageView.snp.bottom).offset(47)
            $0.centerX.equalToSuperview()
        }
        alramLabel.snp.makeConstraints {
            $0.top.equalTo(finishLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
    }

}
