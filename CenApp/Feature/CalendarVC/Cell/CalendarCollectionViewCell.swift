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
    var circleViews: [UIView] = []
    
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
        for circleView in circleViews {
            circleView.removeFromSuperview()
        }
        circleViews.removeAll()
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
    }
    
    func setSundayColor() {
        dayLabel.textColor = .cred
    }
    
    func applyCornerRadius() {
        contentView.layer.cornerRadius = bounds.width / 2
        contentView.clipsToBounds = true
    }
    
    func removeCornerRadius() {
        contentView.layer.cornerRadius = 0
        contentView.clipsToBounds = false
    }
    
    func addCircleViews(count: Int) {
        let maxCircleCount = 3 // 최대 Circle View 개수
        let circleCount = min(count, maxCircleCount) // 서버에서 받은 개수와 최대 개수 중 작은 값을 선택
        for _ in 0..<circleCount {
            let circleView = UIView()
            circleView.backgroundColor = .PrimaryColor
            let circleDiameter: CGFloat = 6 // Circle View 지름
            circleView.layer.cornerRadius = circleDiameter / 2 // 원형으로 설정하기 위해 지름의 절반을 반지름으로 설정
            circleView.clipsToBounds = true // 원형으로 보이도록 설정
            addSubview(circleView)
            circleViews.append(circleView)
        }
        layoutCircleViews()
    }
    
    private func layoutCircleViews() {
        let circleDiameter: CGFloat = 6 // Circle View 지름
        let spacing: CGFloat = 1 // Circle View 간격
        let totalWidth = CGFloat(circleViews.count) * circleDiameter + CGFloat(circleViews.count - 1) * spacing
        var leadingConstraint = (bounds.width - totalWidth) / 2
        for circleView in circleViews {
            circleView.snp.makeConstraints {
                $0.width.height.equalTo(circleDiameter)
                $0.top.equalTo(dayLabel.snp.bottom)
                $0.leading.equalToSuperview().offset(leadingConstraint)
            }
            leadingConstraint += circleDiameter + spacing
        }
    }
}


