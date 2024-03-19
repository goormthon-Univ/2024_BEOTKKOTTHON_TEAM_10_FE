//
//  StartOnboardingViewController.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class StartOnboardingViewController : UIViewController {
    // MARK: - UI Component
    private let image : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.image = UIImage(named: "startOnboarding")
        view.contentMode = .scaleAspectFill
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigationController?.pushViewController(HomeViewController(), animated: true)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.tintColor = .black
    }
}
// MARK: - UI Layout
extension StartOnboardingViewController {
    private func setLayout() {
        self.view.addSubview(image)
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
