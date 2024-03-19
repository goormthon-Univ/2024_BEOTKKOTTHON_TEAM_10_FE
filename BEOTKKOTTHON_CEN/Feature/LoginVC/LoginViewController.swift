//
//  LoginViewController.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/16.
//

import Foundation
import SnapKit
import Alamofire
import Then
import Kingfisher
import UIKit
class LoginViewController : UIViewController, UITextFieldDelegate{
    // MARK: - UI Components
    //탭 제스처
    private lazy var tapGesture : UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        return gesture
    }()
    //아이디
    private let idLabel : UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = .white
        return label
    }()
    private let idView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.3
        return view
    }()
    private let idText : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "ID"
        text.textColor = .black
        text.textAlignment = .left
        return text
    }()
    private let idDescription : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 11)
        label.backgroundColor = .white
        return label
    }()
    //비밀번호
    private let pwLabel : UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = .white
        return label
    }()
    private let pwView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.3
        return view
    }()
    private let pwText : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Password"
        text.textColor = .black
        text.textAlignment = .left
        text.isSecureTextEntry = true
        return text
    }()
    private lazy var pwSecureBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setImage(UIImage(systemName: "eye"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(secureBtnTapped), for: .touchUpInside)
        return btn
    }()
    private let pwDescription : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 11)
        label.backgroundColor = .white
        return label
    }()
    //로그인 버튼
    private lazy var loginBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .customGray
        btn.setTitle("log in\t➔", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        return btn
    }()
    //회원가입
    private lazy var registerBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .SecondaryColor
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        return btn
    }()
    //비밀번호 찾기
    private lazy var findBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .SecondaryColor
        btn.setTitle("비밀번호 찾기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(findBtnTapped), for: .touchUpInside)
        return btn
    }()
    //spacing
    private let spacing : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    //로딩 인디케이터
    private let loadingIndicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .gray
        view.style = .large
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
}
// MARK: - UI Layout
extension LoginViewController {
    private func setLayout() {
        self.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.view.backgroundColor = .white
        self.view.addGestureRecognizer(tapGesture) //제스처등록
        self.view.clipsToBounds = true
        self.idText.delegate = self
        self.pwText.delegate = self
        //아이디
        self.view.addSubview(idLabel)
        self.idView.addSubview(idText)
        self.view.addSubview(idView)
        self.view.addSubview(idDescription)
        
        //패스워드
        self.view.addSubview(pwLabel)
        self.pwView.addSubview(pwText)
        self.pwView.addSubview(pwSecureBtn)
        self.view.addSubview(pwView)
        self.view.addSubview(pwDescription)
        //로그인
        self.view.addSubview(loginBtn)
        self.view.addSubview(spacing)
        
        //회원가입,비밀번호 찾기
        self.view.addSubview(registerBtn)
        self.view.addSubview(findBtn)
        
        //로딩 인디케이터
        self.view.addSubview(loadingIndicator)
        
        //아이디
        idLabel.snp.makeConstraints { make in
            make.left.trailing.equalToSuperview().inset(30)
            make.center.equalToSuperview().offset(-150)
        }
        idText.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(10)
        }
        idView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(idLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        idDescription.snp.makeConstraints { make in
            make.top.equalTo(idView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        //비밀번호
        pwLabel.snp.makeConstraints { make in
            make.left.trailing.equalToSuperview().inset(30)
            make.top.equalTo(idDescription.snp.bottom).offset(20)
        }
        pwText.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(50)
        }
        pwSecureBtn.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(10)
        }
        pwView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(pwLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        pwDescription.snp.makeConstraints { make in
            make.top.equalTo(pwView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        //로그인
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(pwDescription.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        spacing.snp.makeConstraints { make in
            make.top.equalTo(loginBtn.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(0.5)
        }
        
        //회원가입, 비밀번호 찾기
        registerBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.leading.equalToSuperview().offset(70)
        }
        findBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.trailing.equalToSuperview().offset(-70)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(30)
            make.leading.trailing.equalToSuperview().inset(0)
        }
    }
}
// MARK: - TextDelegate
extension LoginViewController {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == idText || textField == pwText {
            if !(idText.text?.isEmpty ?? true) && !(pwText.text?.isEmpty ?? true) {
                loginBtn.backgroundColor = .PrimaryColor
                loginBtn.setTitleColor(.white, for: .normal)
                loginBtn.isEnabled = true
                loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
            } else {
                loginBtn.backgroundColor = .customGray
                loginBtn.setTitleColor(.gray, for: .normal)
                loginBtn.isEnabled = false
            }
        }
    }
}

// MARK: - Actions
extension LoginViewController {
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    @objc private func loginBtnTapped() {
        self.loadingIndicator.startAnimating()
        self.pwDescription.text = ""
        self.idDescription.text = ""
        if let id = idText.text,
            let pw = pwText.text {
            LoginService.requestLogin(userInfo: LoginModel(id: id, pw: pw)) { result in
                if let result = result {
                    if result.message == "success" {
                        self.loadingIndicator.stopAnimating()
                        self.navigationController?.pushViewController(StartOnboardingViewController(), animated: true)
                    }
                }else{
                    self.loadingIndicator.stopAnimating()
                }
            } onError: { error in
                let errorMessage = error.localizedDescription
                if let code = ExpressionService.requestExpression(errorMessage: errorMessage){
                    if code == "401" {
                        self.pwText.text = ""
                        self.pwDescription.text = "* 비밀번호를 다시 확인해주세요"
                        self.loadingIndicator.stopAnimating()
                    }else if code == "402" {
                        self.idText.text = ""
                        self.idDescription.text = "* 등록되지 않은 아이디입니다"
                        self.loadingIndicator.stopAnimating()
                    }
                }else{ }
            }
        }else{
            print("아이디 비번 입력")
        }
    }
    @objc private func registerBtnTapped() {
        self.navigationController?.pushViewController(SignupViewController(), animated: true)
    }
    @objc private func findBtnTapped() {
        
    }
    @objc private func secureBtnTapped() {
        self.pwText.isSecureTextEntry.toggle()
    }
}
