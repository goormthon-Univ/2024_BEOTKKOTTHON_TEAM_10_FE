//
//  CustomProgressViewController.swift
//  CenApp
//
//  Created by 김민솔 on 3/17/24.
//

import UIKit
import Then
import SnapKit

class CustomProgressViewController: UIViewController {
    var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.progressTintColor = UIColor.PrimaryColor
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }

        progressBar.progress = 0.0
        progressBar.layer.cornerRadius = 5
        progressBar.clipsToBounds = true
    }
    
    func updateProgressBar(progress: Float) {
        progressBar.progress = progress
    }

}
