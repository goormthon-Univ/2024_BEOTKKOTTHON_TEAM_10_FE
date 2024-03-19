//
//  IncomeViewController.swift
//  CenApp
//
//  Created by 김민솔 on 3/16/24.
//
import UIKit
import SnapKit
import Then

class IncomeViewController: CustomProgressViewController {
    //MARK: -- UI Component
    private let progressLabel = UILabel().then {
        $0.text = "1/4"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 12)

    }
    private let IncomeChoiceLabel = UILabel().then {
        $0.text = "소득분위를 선택해주세요"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    private lazy var radioButtonStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    } ()
    private lazy var radioButtonStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    } ()
    private let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.backgroundColor = UIColor.SecondaryColor
        $0.setTitleColor(.gray, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgressBar(progress: 1/4)
        navigationControl()
        addSubviews()
        configUI()
        createRadioButtons()
        view.backgroundColor = .white
    }
    //MARK: -- UINavigation
    func navigationControl() {
        //navigationBar 바꾸는 부분
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.title = "정보 입력"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
    }
    func addSubviews() {
        view.addSubview(progressLabel)
        view.addSubview(IncomeChoiceLabel)
        view.addSubview(radioButtonStackView1)
        view.addSubview(radioButtonStackView2)
        view.addSubview(nextButton)
    }
    func configUI() {
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.centerX.equalToSuperview()
        }
        IncomeChoiceLabel.snp.makeConstraints {
            $0.top.equalTo(progressLabel.snp.bottom).offset(85)
            $0.centerX.equalToSuperview()
        }
        radioButtonStackView1.snp.makeConstraints {
            $0.top.equalTo(IncomeChoiceLabel.snp.bottom).offset(90)
            $0.centerX.equalToSuperview()
        }
        radioButtonStackView2.snp.makeConstraints {
            $0.top.equalTo(radioButtonStackView1.snp.bottom).offset(40)
            $0.leading.equalTo(radioButtonStackView1.snp.leading)
            $0.trailing.equalTo(radioButtonStackView1.snp.trailing)
        }
        nextButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-40)
        }
        
    }
    //MARK: -- Radio Button Creation
    func createRadioButtons() {
        let radioButttonTitles = ["1", "2", "3", "4", "5",
                                  "6", "7", "8", "9", "10"]
        for (index, title) in radioButttonTitles.enumerated() {
           let radioButton = UIButton(type: .custom)
           
           // 이미지 설정
           radioButton.setImage(UIImage(named: "Border"), for: .normal)
           radioButton.setImage(UIImage(named: "Empty"), for: .selected)
           
           // 제목 설정
            radioButton.setTitle(title, for: .normal)
            radioButton.setTitleColor(UIColor.black, for: .selected)
            radioButton.backgroundColor = .clear
            
           // 제목 색상 및 위치 설정
           radioButton.setTitleColor(UIColor.black, for: .normal)
           radioButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            radioButton.alignTextBelow()
           radioButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
           
           if index < 5 {
               radioButtonStackView1.addArrangedSubview(radioButton)
           } else {
               radioButtonStackView2.addArrangedSubview(radioButton)
           }
       }
    }

    @objc func radioButtonTapped(_ sender: UIButton) {
        // 이미지 변경 및 선택 상태 반전
        sender.isSelected = true
        for subview in radioButtonStackView1.arrangedSubviews + radioButtonStackView2.arrangedSubviews {
            if let radioButton = subview as? UIButton, radioButton != sender {
                radioButton.isSelected = false
            }
        }
        if radioButtonIsSelected() {
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor.PrimaryColor
            nextButton.setTitleColor(.white, for: .normal)
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.SecondaryColor
            nextButton.setTitleColor(.gray, for: .normal)
        }
    }

    func radioButtonIsSelected() -> Bool {
        for subview in radioButtonStackView1.arrangedSubviews + radioButtonStackView2.arrangedSubviews {
            if let radioButton = subview as? UIButton, radioButton.isSelected {
                return true
            }
        }
        return false
    }
    @objc func nextButtonTapped(_ sender: UIButton) {
        let academicVC = AcademicYearViewController()
        self.navigationController?.pushViewController(academicVC, animated: true)
    }

}
extension UIButton {
    func alignTextBelow(spacing: CGFloat = 4.0) {
            guard let image = self.imageView?.image else {
                return
            }

            guard let titleLabel = self.titleLabel else {
                return
            }

            guard let titleText = titleLabel.text else {
                return
            }

            let titleSize = titleText.size(withAttributes: [
                NSAttributedString.Key.font: titleLabel.font as Any
            ])

            titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
        }
}

