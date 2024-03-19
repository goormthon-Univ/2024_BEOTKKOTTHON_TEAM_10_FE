//
//  RegisterViewController.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import SnapKit
import Alamofire
import Then
import Kingfisher
import UIKit
class SignupViewController : UIViewController, UITextFieldDelegate{
    // MARK: - UI Components
    //탭 제스처
    private lazy var tapGesture : UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        return gesture
    }()
    //타이틀
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    //이름
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = .white
        return label
    }()
    private let nameView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.3
        return view
    }()
    private let nameText : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Name"
        text.textColor = .black
        text.textAlignment = .left
        return text
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
        label.text = "*사용가능한 아이디입니다"
        label.textColor = .black
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
        label.text = "*몇자리 이상, 기호 포함"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 11)
        label.backgroundColor = .white
        return label
    }()
    private let repwLabel : UILabel = {
        let label = UILabel()
        label.text = "비밀번호 재확인"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = .white
        return label
    }()
    private let repwView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.3
        return view
    }()
    private let repwText : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Password"
        text.textColor = .black
        text.textAlignment = .left
        text.isSecureTextEntry = true
        return text
    }()
    private lazy var repwSecureBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setImage(UIImage(systemName: "eye"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(resecureBtnTapped), for: .touchUpInside)
        return btn
    }()
    private let repwDescription : UILabel = {
        let label = UILabel()
        label.text = "*비밀번호가 일치하지 않습니다"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 11)
        label.backgroundColor = .white
        return label
    }()
    //로그인 버튼
    private lazy var loginBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .customGray
        btn.setTitle("join in\t➔", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
}
// MARK: - UI Layout
extension SignupViewController {
    private func setLayout() {
        self.view.backgroundColor = .white
        self.view.addGestureRecognizer(tapGesture)
        self.nameText.delegate = self
        self.idText.delegate = self
        self.pwText.delegate = self
        self.repwText.delegate = self
        //타이틀
        self.view.addSubview(titleLabel)
        //이름
        self.view.addSubview(nameLabel)
        self.nameView.addSubview(nameText)
        self.view.addSubview(nameView)
        
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
        
        //비밀번호 재확인
        self.view.addSubview(repwLabel)
        self.repwView.addSubview(repwText)
        self.repwView.addSubview(repwSecureBtn)
        self.view.addSubview(repwView)
        self.view.addSubview(repwDescription)
        
        //로그인
        self.view.addSubview(loginBtn)
        //타이틀
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalToSuperview().offset(self.view.frame.height/8)
        }
        //이름
        nameLabel.snp.makeConstraints { make in
            make.left.trailing.equalToSuperview().inset(30)
            make.center.equalToSuperview().offset(-200)
        }
        nameText.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(10)
        }
        nameView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        
        //아이디
        idLabel.snp.makeConstraints { make in
            make.left.trailing.equalToSuperview().inset(30)
            make.top.equalTo(nameView.snp.bottom).offset(10)
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
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(idDescription.snp.bottom).offset(10)
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
        
        repwLabel.snp.makeConstraints { make in
            make.left.trailing.equalToSuperview().inset(30)
            make.top.equalTo(pwDescription.snp.bottom).offset(10)
        }
        repwText.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(50)
        }
        repwSecureBtn.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(10)
        }
        repwView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(repwLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        repwDescription.snp.makeConstraints { make in
            make.top.equalTo(repwView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        //로그인
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(repwDescription.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
    }
}
// MARK: - TextDelegate
extension SignupViewController {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == idText || textField == pwText || textField == repwText || textField == nameText{
            if !(idText.text?.isEmpty ?? true) && !(pwText.text?.isEmpty ?? true) && !(repwText.text?.isEmpty ?? true) && !(nameText.text?.isEmpty ?? true)  {
                loginBtn.backgroundColor = .PrimaryColor
                loginBtn.setTitleColor(.white, for: .normal)
                loginBtn.isEnabled = true
            } else {
                loginBtn.backgroundColor = .lightGray
                loginBtn.setTitleColor(.gray, for: .normal)
                loginBtn.isEnabled = false
            }
        }
    }
}

// MARK: - Actions
extension SignupViewController {
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    @objc private func loginBtnTapped() {
        
    }
    @objc private func secureBtnTapped() {
        self.pwText.isSecureTextEntry.toggle()
    }
    @objc private func resecureBtnTapped() {
        self.repwText.isSecureTextEntry.toggle()
    }
}
