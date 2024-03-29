//
//  MajorViewController.swift
//  CenApp
//
//  Created by 김민솔 on 3/17/24.
//

import UIKit

class MajorViewController: CustomProgressViewController {
    var ranking: String?
    var grade: String?
    var major: String?
    let majorArray = ["공학계열","교육게열","사회계열","예체능계열","의약계열","인문계열","자연계열"]
    //MARK: -- UI Component
    private let progressLabel = UILabel().then {
        $0.text = "3/4"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 12)

    }
    private let IncomeChoiceLabel = UILabel().then {
        $0.text = "전공계열을 선택해주세요"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    private let containerView = UIView().then {
        $0.layer.borderColor = UIColor.SecondaryColor.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private lazy var majorStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 7
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
        updateProgressBar(progress: 3/4)
        addSubviews()
        configUI()
        createMajorButtons()
        view.backgroundColor = .white
    }
    func addSubviews() {
        view.addSubview(progressLabel)
        view.addSubview(IncomeChoiceLabel)
        view.addSubview(containerView)
        view.addSubview(nextButton)
        containerView.addSubview(majorStackview)
        
    }
    func configUI() {
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.height.equalTo(15)
            $0.centerX.equalToSuperview()
        }
        IncomeChoiceLabel.snp.makeConstraints {
            $0.top.equalTo(progressLabel.snp.bottom).offset(75)
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
            $0.top.equalTo(IncomeChoiceLabel.snp.bottom).offset(55)
            $0.bottom.equalTo(nextButton.snp.top).offset(-90)
        }
        majorStackview.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        nextButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
    func createMajorButtons() {
        for major in majorArray {
            let button = UIButton()
            button.setTitle(major, for: .normal)
            button.titleLabel?.textAlignment = .left
            button.contentHorizontalAlignment = .left
            button.backgroundColor = UIColor.ThirdaryColor
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            button.addTarget(self, action: #selector(majorButtonTapped(_:)), for: .touchUpInside)
            majorStackview.addArrangedSubview(button)
        }
    }
    @objc func majorButtonTapped(_ sender: UIButton) {
        sender.backgroundColor = UIColor.PrimaryColor
        sender.setTitleColor(.white, for: .normal)
        
        self.major = sender.titleLabel?.text
        
        for subview in majorStackview.arrangedSubviews {
            if let button = subview as? UIButton, button != sender {
                button.backgroundColor = .ThirdaryColor
                button.setTitleColor(.black, for: .normal)
            }
        }
        nextButton.backgroundColor = UIColor.PrimaryColor
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.isEnabled = true
    }
    @objc func nextButtonTapped(_ sender: UIButton) {
        guard let selectedMajor = self.major, let grade = self.grade, let ranking = self.ranking else {
            // 전공이 선택되지 않은 경우에는 메서드 종료
            return
        }
            // 선택된 전공 값을 LocationViewController로 전달
        let locationVC = LocationViewController()
        locationVC.major = selectedMajor
        locationVC.ranking = ranking
        locationVC.grade = grade
            print("Selected grade:", grade)
            print("Selected ranking:", ranking)
            print("Selected major:",selectedMajor)
            self.navigationController?.pushViewController(locationVC, animated: true)
        }
   

}
