//
//  MypopupView.swift
//  CenApp
//
//  Created by 김민솔 on 3/22/24.
//

import UIKit
import SnapKit
import Then

class MyPopupView: UIView {
   
    private let popupView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    private let bodyStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 8
      }
    private let ingView = UIView().then {
        $0.backgroundColor = .ThirdaryColor
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        
    }
    private let ingLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "지원 중"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textAlignment = .left
    }
    private let ingButton = UIButton().then {
        $0.setImage(UIImage(named: "Vector"), for: .normal)
    }
    private let finishView = UIView().then {
        $0.backgroundColor = .ThirdaryColor
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let finishLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "지원 완료"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textAlignment = .left
    }
    private let finishButton = UIButton().then {
        $0.setImage(UIImage(named: "Ellipse3"), for: .normal)
    }
    private let cancelButton = UIButton().then {
        $0.setImage(UIImage(named: "Cancel"), for: .normal)
    }
    private let cancelLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "저장 취소"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textAlignment = .left
    }
    private let cancelView = UIView().then {
        $0.backgroundColor = .ThirdaryColor
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let titleLabel = UILabel().then {
      $0.textColor = .black
      $0.font = UIFont.boldSystemFont(ofSize: 20)
      $0.numberOfLines = 0
      $0.textAlignment = .left
    }
  
    init(title: String) {
        self.titleLabel.text = title
        super.init(frame: .zero)
        
        self.backgroundColor = .black.withAlphaComponent(0.3)
        self.addSubview(self.popupView)
        popupView.addSubview(titleLabel)
        popupView.addSubview(bodyStackView)
        bodyStackView.addArrangedSubview(ingView)
        bodyStackView.addArrangedSubview(finishView)
        bodyStackView.addArrangedSubview(cancelView)
        ingView.addSubview(ingLabel)
        ingView.addSubview(ingButton)
        finishView.addSubview(finishLabel)
        finishView.addSubview(finishButton)
        cancelView.addSubview(cancelButton)
        cancelView.addSubview(cancelLabel)
        
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalToSuperview().offset(18)
        }
        self.popupView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(250)
        }
        self.bodyStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(27)
            $0.leading.trailing.bottom.equalToSuperview().inset(14)
        }
        
        ingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(65)
            $0.leading.equalToSuperview().offset(10)
        }
        ingButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(ingLabel.snp.trailing).offset(40)
        }
        finishLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(65)
            $0.leading.equalToSuperview().offset(10)
        }
        finishButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(finishLabel.snp.trailing).offset(40)
        }
        cancelLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(65)
            $0.leading.equalToSuperview().offset(10)
        }
        cancelButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(cancelLabel.snp.trailing).offset(40)
        }
        
    
    }
    
    //지원 완료 버튼 눌를 시
    @objc private func finishButtonTapped() {
        //지원 완료 이미지로 바뀜
        
    }
    //지원 중 버튼 눌를 시
    @objc private func ingButtonTapped() {
        dismissPopup()
    }
    @objc private func cancelButtonTapped() {
        dismissPopup()
    }

    private func dismissPopup() {
        self.alpha = 0 // 투명도를 0으로 설정하여 화면에서 사라지도록 함
        self.removeFromSuperview()
    }

  required init?(coder: NSCoder) { fatalError() }
}

extension UIColor {
  func asImage(_ width: CGFloat = UIScreen.main.bounds.width, _ height: CGFloat = 1.0) -> UIImage {
    let size: CGSize = CGSize(width: width, height: height)
    let image: UIImage = UIGraphicsImageRenderer(size: size).image { context in
      setFill()
      context.fill(CGRect(origin: .zero, size: size))
    }
    return image
  }
}
