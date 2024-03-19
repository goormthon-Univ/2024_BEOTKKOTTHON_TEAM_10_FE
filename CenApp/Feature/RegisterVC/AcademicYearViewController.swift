//
//  AcademicYearViewController.swift
//  CenApp
//
//  Created by 김민솔 on 3/17/24.
//

import UIKit
import Then
import SnapKit

class AcademicYearViewController: CustomProgressViewController {
    //MARK: -- UI Component
    private let progressLabel = UILabel().then {
        $0.text = "2/4"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 12)

    }
    private let oneContainerView = UIView().then {
        $0.layer.borderColor = UIColor.ThirdaryColor.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let twoContainerView = UIView().then {
        $0.layer.borderColor = UIColor.ThirdaryColor.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let threeContainerView = UIView().then {
        $0.layer.borderColor = UIColor.ThirdaryColor.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let FourContainerView = UIView().then {
        $0.layer.borderColor = UIColor.ThirdaryColor.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    private let oneImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "OneGrade")
    }
    private let twoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "TwoGrade")
    }
    private let threeImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "ThreeGrade")
    }
    private let fourImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "FourGrade")
    }
    private let ondGradeLabel = UILabel().then {
        $0.text = "1학년"
        $0.textAlignment = .center
        $0.textColor = UIColor.black
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    private let twoGradeLabel = UILabel().then {
        $0.text = "2학년"
        $0.textAlignment = .center
        $0.textColor = UIColor.black
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    private let threeGradeLabel = UILabel().then {
        $0.text = "3학년"
        $0.textAlignment = .center
        $0.textColor = UIColor.black
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    private let fourGradeLabel = UILabel().then {
        $0.text = "4학년"
        $0.textAlignment = .center
        $0.textColor = UIColor.black
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    private let gradeChoiceLabel = UILabel().then {
        $0.text = "학년을 선택해주세요"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    
    private let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.backgroundColor = UIColor.SecondaryColor
        $0.setTitleColor(.gray, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.isUserInteractionEnabled = false
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgressBar(progress: 2/4)
        addSubviews()
        configUI()
        tapGesture()
        view.backgroundColor = .white
    }
    func addSubviews() {
        view.addSubview(progressLabel)
        view.addSubview(gradeChoiceLabel)
        view.addSubview(oneContainerView)
        oneContainerView.addSubview(oneImageView)
        oneContainerView.addSubview(ondGradeLabel)
        view.addSubview(twoContainerView)
        twoContainerView.addSubview(twoImageView)
        twoContainerView.addSubview(twoGradeLabel)
        view.addSubview(threeContainerView)
        threeContainerView.addSubview(threeImageView)
        threeContainerView.addSubview(threeGradeLabel)
        view.addSubview(FourContainerView)
        FourContainerView.addSubview(fourImageView)
        FourContainerView.addSubview(fourGradeLabel)
        view.addSubview(nextButton)
        
        
    }
    func tapGesture() {
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(containerViewTapped(_:)))
        oneContainerView.addGestureRecognizer(tapGesture1)
               
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(containerViewTapped(_:)))
        twoContainerView.addGestureRecognizer(tapGesture2)
       
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(containerViewTapped(_:)))
        threeContainerView.addGestureRecognizer(tapGesture3)
       
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(containerViewTapped(_:)))
        FourContainerView.addGestureRecognizer(tapGesture4)
    }
    func configUI() {
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.centerX.equalToSuperview()
        }
        gradeChoiceLabel.snp.makeConstraints {
            $0.top.equalTo(progressLabel.snp.bottom).offset(75)
            $0.centerX.equalToSuperview()
        }
        oneContainerView.snp.makeConstraints {
            $0.top.equalTo(gradeChoiceLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(75)
            $0.trailing.equalTo(twoContainerView.snp.leading).offset(-20)
            $0.width.equalTo(113)
            $0.height.equalTo(155)
        }
        oneImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(113)
            $0.height.equalTo(117)
            
        }
        ondGradeLabel.snp.makeConstraints {
            $0.top.equalTo(oneImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        twoContainerView.snp.makeConstraints {
            $0.top.equalTo(gradeChoiceLabel.snp.bottom).offset(40)
            $0.leading.equalTo(oneContainerView.snp.trailing).offset(20)
            $0.width.equalTo(113)
            $0.height.equalTo(155)
        }
        twoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(113)
            $0.height.equalTo(117)
            
        }
        twoGradeLabel.snp.makeConstraints {
            $0.top.equalTo(oneImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        threeContainerView.snp.makeConstraints {
            $0.top.equalTo(oneContainerView.snp.bottom).offset(20)
            $0.leading.equalTo(oneContainerView.snp.leading)
            $0.width.equalTo(113)
            $0.height.equalTo(155)
        }
        threeImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(113)
            $0.height.equalTo(117)
            
        }
        threeGradeLabel.snp.makeConstraints {
            $0.top.equalTo(threeImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        FourContainerView.snp.makeConstraints {
            $0.top.equalTo(twoContainerView.snp.bottom).offset(20)
            $0.leading.equalTo(twoContainerView.snp.leading)
            $0.width.equalTo(113)
            $0.height.equalTo(155)
        }
        fourImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(113)
            $0.height.equalTo(117)
            
        }
        fourGradeLabel.snp.makeConstraints {
            $0.top.equalTo(fourImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        nextButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-50)
        }
       
        
        
    }
    @objc func nextButtonTapped(_ sender: UIButton) {
        let majorVC = MajorViewController()
        self.navigationController?.pushViewController(majorVC, animated: true)
    }
    @objc func containerViewTapped(_ sender: UITapGestureRecognizer) {
        oneContainerView.layer.borderColor = UIColor.ThirdaryColor.cgColor
        twoContainerView.layer.borderColor = UIColor.ThirdaryColor.cgColor
        threeContainerView.layer.borderColor = UIColor.ThirdaryColor.cgColor
        FourContainerView.layer.borderColor = UIColor.ThirdaryColor.cgColor
           if let tappedView = sender.view {
               tappedView.layer.borderColor = UIColor.PrimaryColor.cgColor
           }
        nextButton.isUserInteractionEnabled = true
        nextButton.backgroundColor = UIColor.PrimaryColor
        nextButton.setTitleColor(.white, for: .normal)
    }
}
