//
//  CalendarCollectionViewCell.swift
//  CenApp
//
//  Created by 김민솔 on 3/20/24.
// 달력 날짜 컬렉션 뷰 

import UIKit
import SnapKit
import Then

class CalendarCollectionViewCell: UICollectionViewCell {
    static let identifier = "CalendarCollectionViewCell"
    
    lazy var dayLabel = UILabel()
    lazy var circleView: UIView = UIView() // 단일 circle view
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override func prepareForReuse() {
        dayLabel.text = nil
        circleView.isHidden = true // circle view를 숨김
    }
    
    func update(day: String) {
        dayLabel.text = day
    }
    
    func configure() {
        addSubview(dayLabel)
        dayLabel.textColor = .black
        dayLabel.font = UIFont.boldSystemFont(ofSize: 15)
        dayLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
        }
        addCircleView()
    }
    
    func setSundayColor() {
        dayLabel.textColor = .red // 색상 변경
    }
    
    private func addCircleView() {
        circleView.backgroundColor = .PrimaryColor // 원하는 색상 설정
        let circleDiameter: CGFloat = 6 // Circle View 지름
        circleView.layer.cornerRadius = circleDiameter / 2 // 원형으로 설정하기 위해 지름의 절반을 반지름으로 설정
        circleView.clipsToBounds = true // 원형으로 보이도록 설정
        addSubview(circleView)
        
        // Circle View를 dayLabel 아래에 배치
        circleView.snp.makeConstraints {
            $0.width.height.equalTo(circleDiameter)
            $0.top.equalTo(dayLabel.snp.bottom).offset(4) // 조정 가능한 값
            $0.centerX.equalToSuperview()
        }
    }
}


