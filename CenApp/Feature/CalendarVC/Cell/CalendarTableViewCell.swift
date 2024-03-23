//
//  CalendarTableViewCell.swift
//  CenApp
//
//  Created by 김민솔 on 3/20/24.
//

import UIKit
import SnapKit
class CalendarTableViewCell: UITableViewCell {
    static let identifier = "CalendarTableViewCell"
    weak var delegate: CalendarTableViewCellDelegate?

    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.layer.masksToBounds = true
        return label
    }()
    //전체 뷰
    private let totalView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    private let companyLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "(주)우아한 청년들"
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.layer.cornerRadius = 10
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.layer.masksToBounds = true
        return label
    }()
    private let titleText: UITextView = {
        let label = UITextView()
        label.textColor = .black
        label.text = "2024년 우아한 사장님 자녀 장학금 지원 대학생 일반 장학생 모집"
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.isEditable = false
        label.isScrollEnabled = false
        return label
    }()
    private let deadlineLabel : UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "D-1"
        label.textAlignment = .center
        label.backgroundColor = UIColor.PrimaryColor2
        label.layer.cornerRadius = 5
        label.font = UIFont.systemFont(ofSize: 13)
        label.layer.masksToBounds = true
        return label
    }()
    private let ingView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.cGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    } ()
    private let ingButton = UIButton().then {
        $0.setImage(UIImage(named: "Ellipse"), for: .normal)

    }
    private func addTapGestureToIngView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ingViewTapped))
        ingView.addGestureRecognizer(tapGesture)
    }
    private func addTapGestureToIngButton() {
        ingButton.addTarget(self, action: #selector(ingButtonTapped), for: .touchUpInside)
    }
    // ingView 클릭 시 호출되는 메서드
    @objc func ingViewTapped() {
        delegate?.ingViewDidTap()
        }
    // ingButton 클릭 시 호출되는 메서드
    @objc func ingButtonTapped() {
        print("ingButtonTapped() called")

        delegate?.ingButtonDidTap()
    }
   //진행상황 버튼
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.dayLabel.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        addTapGestureToIngView()
        addTapGestureToIngButton()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        let view = self.contentView
        view.backgroundColor = .PrimaryColor2
        view.addSubview(dayLabel)
        totalView.addSubview(companyLabel)
        totalView.addSubview(titleText)
        totalView.addSubview(deadlineLabel)
        totalView.addSubview(ingView)
        ingView.addSubview(ingButton)
        view.addSubview(totalView)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dayLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        companyLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(20)
            make.height.equalTo(15)
            make.width.equalToSuperview().dividedBy(2)
        }
        titleText.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(companyLabel.snp.bottom).offset(10)
            make.width.equalToSuperview().dividedBy(1.5)
            make.bottom.equalToSuperview().inset(10)
        }
        deadlineLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        ingView.snp.makeConstraints { make in
            make.top.equalTo(deadlineLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(deadlineLabel)
            make.height.equalTo(35)
        }
        ingButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        totalView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(dayLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
    }
    func update(day: String) {
        self.dayLabel.text = day
    }
}
protocol CalendarTableViewCellDelegate: AnyObject {
    func ingViewDidTap()
    func ingButtonDidTap()
}
