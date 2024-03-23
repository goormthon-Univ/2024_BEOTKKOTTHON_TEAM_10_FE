//
//  PopupViewController.swift
//  CenApp
//
//  Created by 김민솔 on 3/22/24.
//
import UIKit

class PopupViewController: UIViewController {
    private let popupView: MyPopupView
    
    init(title: String) {
        self.popupView = MyPopupView(title: title)
        super.init(nibName: nil, bundle: nil)
        
        // 배경 뷰에 탭 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        self.view.addGestureRecognizer(tapGesture)
        
        self.view.backgroundColor = .clear
        self.view.addSubview(self.popupView)
        self.popupView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // 배경 뷰를 탭하면 호출되는 메서드
    @objc private func backgroundTapped() {
        dismiss(animated: true, completion: nil) // 팝업 닫기
    }
}

