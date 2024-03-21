//
//  FindpwViewController.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/21.
//

import Foundation
import SnapKit
import Alamofire
import Then
import Kingfisher
import UIKit
class FindpwViewController : UIViewController, UITextFieldDelegate{
    // MARK: - UI Components
    //탭 제스처
    private lazy var tapGesture : UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        return gesture
    }()
    //타이틀
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "비밀번호 찾기"
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
        label.text = ""
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 11)
        label.backgroundColor = .white
        return label
    }()
    //비밀번호
    private let pwLabel : UILabel = {
        let label = UILabel()
        label.text = "새로운 비밀번호"
        label.textColor = .PrimaryColor
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
        btn.backgroundColor = .cGray
        btn.setTitle("확인", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        return btn
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
        self.navigationController?.navigationItem.hidesBackButton = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationItem.hidesBackButton = true
    }
}
// MARK: - UI Layout
extension FindpwViewController {
    private func setLayout() {
        self.view.backgroundColor = .white
        self.view.addGestureRecognizer(tapGesture)
        self.view.clipsToBounds = true
        self.title = ""
        self.nameText.delegate = self
        self.idText.delegate = self
        self.pwText.delegate = self
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
        
        //비밀번호
        self.view.addSubview(pwLabel)
        self.pwView.addSubview(pwText)
        self.pwView.addSubview(pwSecureBtn)
        self.view.addSubview(pwView)
        self.view.addSubview(pwDescription)
        
        //로그인
        self.view.addSubview(loginBtn)
        
        //로딩 인디케이터
        self.view.addSubview(loadingIndicator)
        //타이틀
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalToSuperview().offset(self.view.frame.height/8)
        }
        //이름
        nameLabel.snp.makeConstraints { make in
            make.left.trailing.equalToSuperview().inset(30)
            make.center.equalToSuperview().offset(-150)
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
            make.top.equalTo(nameView.snp.bottom).offset(30)
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
            make.top.equalTo(idDescription.snp.bottom).offset(30)
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
        //로딩 인디케이터
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(30)
            make.leading.trailing.equalToSuperview().inset(0)
        }
    }
}
// MARK: - TextDelegate
extension FindpwViewController {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == idText || textField == nameText || textField == pwText{
            if !(idText.text?.isEmpty ?? true) && !(nameText.text?.isEmpty ?? true)  && !(pwText.text?.isEmpty ?? true) {
                loginBtn.backgroundColor = .PrimaryColor
                loginBtn.setTitleColor(.white, for: .normal)
                loginBtn.isEnabled = true
                loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
            } else {
                loginBtn.backgroundColor = .cGray
                loginBtn.setTitleColor(.gray, for: .normal)
                loginBtn.isEnabled = false
            }
        }
    }
}

// MARK: - Actions
extension FindpwViewController {
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    @objc private func loginBtnTapped() {
        self.loadingIndicator.startAnimating()
        self.pwDescription.text = ""
        self.idDescription.text = ""
        if  let name = nameText.text,
            let id = idText.text,
            let pw = pwText.text{
            FindpwService.requestFindpw(userInfo: FindpwModel(userid: id, password: pw, name: name)) { result in
                if let result = result {
                    if result.message == "success" {
                        self.loadingIndicator.stopAnimating()
                    }else if result.message == "no user" {
                        self.idDescription.text = "* 등록되지 않은 아이디입니다"
                        self.loadingIndicator.stopAnimating()
                    }
                }else{
                    self.loadingIndicator.stopAnimating()
                }
            } onError: { error in
                self.idDescription.text = "* 등록되지 않은 아이디입니다"
                self.loadingIndicator.stopAnimating()
            }
        }else{
            print("아이디 비번 입력")
        }
    }
    @objc private func secureBtnTapped() {
        self.pwText.isSecureTextEntry.toggle()
    }
}
