//
//  CalendarViewController.swift
//  CenApp
//
//  Created by 김민솔 on 3/19/24.
// 남은거 - 셀 클릭 시 배경색
// 남은거 - 셀 클릭 시 그에 맞는 서류 공고
import Foundation
import UIKit
import SnapKit
import Then
import Charts
import Alamofire
import SwiftKeychainWrapper

class CalendarViewController: UIViewController {
    var isSelectedCell = false // 선택 여부를 추적하는 변수
    private lazy var weekStackView = UIStackView()
    private lazy var calendarView = UIView()
    private var currentDate = Date() // 현재 날짜를 가져옴
    private lazy var titleLabel = UILabel()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var calendarDate = Date()
    private var days = [String]()
    //MARK: - UI Component
    private let containerView = UIView().then {
        $0.backgroundColor = UIColor.PrimaryColor2
    }
    private let barView = UIView().then {
        $0.layer.backgroundColor = UIColor.ThirdaryColor.cgColor
    }
    private let calendartTableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .SecondaryColor
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.identifier)
        view.isScrollEnabled = true
        view.clipsToBounds = true
        return view
    }()
    //재로드 refresh
    private lazy var refreshIndicator : UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .SecondaryColor
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return control
    }()
    //MARK: -- 함수호출
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = String(format: "%02d", calendar.component(.month, from: currentDate))
        //fetchMonthData(year: String(year), month: month)
        view.backgroundColor = .white
        addSubviews()
        configure()
        configUI()
      
    }
    
    func configure() {
        configureTitleLabel()
        configureWeekStackView()
        configureWeekLabel()
        configureTableView()
        configureCollectionView()
        self.configureCalendar()
        
    }
    func addSubviews() {
        view.addSubview(containerView)
        calendarView.addSubview(barView)
        self.calendartTableView.addSubview(refreshIndicator)
        self.containerView.addSubview(calendarView)
        containerView.addSubview(calendartTableView)
    }
    func configUI() {
        let topInset: CGFloat = 15
        let calendarHeightRatio: CGFloat = 2.5 / 4.0
        let tableViewHeightRatio: CGFloat = 1.5 / 4.0
        containerView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        calendarView.backgroundColor = UIColor.white
        barView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(weekStackView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(14)
        }
        calendarView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(topInset)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(calendarHeightRatio)
        }
        calendartTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(tableViewHeightRatio)
            make.top.equalTo(calendarView.snp.bottom)
        }
    }
    private func configureTitleLabel() {
        self.calendarView.addSubview(self.titleLabel)
        self.titleLabel.text = getCurrentMonth()
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.font = UIFont.systemFont(ofSize: 30)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.calendarView.topAnchor, constant: 20),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.calendarView.centerXAnchor)
        ])
    }
    private func getCurrentMonth() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        return formatter.string(from: currentDate)
    }
    private func configureWeekStackView() {
        self.calendarView.addSubview(self.weekStackView)
        self.weekStackView.distribution = .fillEqually
        weekStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
    }
    private func configureWeekLabel() {
        let dayOfTheWeek = ["ㅇ", "ㅇ", "ㅎ", "ㅅ", "ㅁ", "ㄱ", "ㅌ"]
        
        for (index, day) in dayOfTheWeek.enumerated() {
            let label = UILabel()
            label.text = day
            label.textAlignment = .center
            
            if index == 0 {
                label.textColor = UIColor.red
            } else if index == dayOfTheWeek.count - 1 {
                label.textColor = UIColor.blue
            } else {
                label.textColor = UIColor.black
            }
            
            self.weekStackView.addArrangedSubview(label)
        }
    }
    private func configureTableView() {
        self.calendartTableView.delegate = self
        self.calendartTableView.dataSource = self
    }
    private func configureCollectionView() {
        self.calendarView.addSubview(self.collectionView)
        collectionView.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isScrollEnabled = false
        self.collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(barView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(6)
            $0.bottom.equalToSuperview()
        }
    }
    //해당 년/월 서버
    func fetchMonthData(year: String, month:String) {
        let url = "https://www.dolshoi./calendar/\(year)/\(month)"
        if let JWTaccesstoken = KeychainWrapper.standard.string(forKey: "JWTaccesstoken") {
            AF.request(url, method: .get, headers: ["accesstoken" : JWTaccesstoken])
                .validate(statusCode: 200..<300) // 상태 코드가 200~299 사이인지 확인
                .responseJSON { [weak self] response in
                    guard let self = self else { return }
                    
                    switch response.result {
                    case .success(let value):
                        // 성공적으로 데이터를 가져온 경우 처리
                        if let jsonArray = value as? [[String: Any]] {
                            // 여기서 jsonArray를 모델로 파싱하고 사용합니다.
                            for item in jsonArray {
                                if let title = item["title"] as? String {
                                    print("Title:", title)
                                }
                                // 다른 필요한 데이터도 처리합니다.
                            }
                        }
                    case .failure(let error):
                        // 데이터 가져오기 실패한 경우 처리
                        print("Error:", error.localizedDescription)
                    }
            }
        }
    }
    
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.days.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        cell.update(day: self.days[indexPath.item])
        if indexPath.item % 7 == 0 {
                cell.setSundayColor()
        }
        cell.addCircleViews(count: 3)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 선택된 날짜 가져오기
        let selectedDate = calendar.date(byAdding: .day, value: indexPath.item - startDayOfTheWeek(), to: calendar.startOfDay(for: calendarDate))!

        // 선택된 날짜가 현재 월에 있는지 확인
        if !calendar.isDate(selectedDate, equalTo: calendarDate, toGranularity: .month) {
//            dispatchGroup.leave()
            return
        }
        // 선택된 셀의 모습 업데이트
            if let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell {
                cell.backgroundColor = .PrimaryColor2
                cell.layer.cornerRadius = 12 // 필요에 따라 조정
                cell.layer.masksToBounds = true
                
                // 선택된 날짜의 연도, 월, 일 구성 요소 가져오기
                let year = calendar.component(.year, from: selectedDate)
                let month = String(format: "%02d", calendar.component(.month, from: selectedDate))
                let day = calendar.component(.day, from: selectedDate)
                print(year)
                print(month)
                print(day)
                cell.isSelected = !cell.isSelected
                let tableViewIndexPath = IndexPath(row: 0, section: 0)

                updateDayLabel(at: tableViewIndexPath, with: "\(month)월 \(day)일" )
            }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.collectionView.frame.width - 30) / 7
        return CGSize(width: width, height: width * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
}
//MARK: - CalendarTableViewCellDelegate
extension CalendarViewController: CalendarTableViewCellDelegate {
    func ingButtonDidTap() {
        print("button tapped")
        let popupVC = PopupViewController(title: "지원상태 변경")
        popupVC.modalPresentationStyle = .overFullScreen
        present(popupVC, animated: false)
    }
    
    func ingViewDidTap() {
        print("view tapped")
        let popupVC = PopupViewController(title: "지원상태 변경")
        popupVC.modalPresentationStyle = .overFullScreen
        present(popupVC, animated: false)
    }
}
//MARK: - TableViewDelegate, TableViewDataSource

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CalendarTableViewCell.identifier, for: indexPath) as! CalendarTableViewCell
        cell.delegate = self //델리게이트 설정
        cell.selectionStyle = .none
        return cell
    }
    //테이블 뷰 셀 클릭 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell click")
    }
    @objc private func refreshData() {
        refreshIndicator.endRefreshing()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func updateDayLabel(at indexPath: IndexPath, with text: String) {
        if let cell = calendartTableView.cellForRow(at: indexPath) as? CalendarTableViewCell {
            print(text)
            print("클릭 ")
            cell.update(day: text)
        }
    }
}

extension CalendarViewController {
    
    private func configureCalendar() {
        self.dateFormatter.dateFormat = "M월"
        self.today()
    }
    
    private func startDayOfTheWeek() -> Int {
        return self.calendar.component(.weekday, from: self.calendarDate) - 1
    }
    
    private func endDate() -> Int {
        return self.calendar.range(of: .day, in: .month, for: self.calendarDate)?.count ?? Int()
    }
    
    private func updateCalendar() {
        self.updateTitle()
        self.updateDays()
    }
    
    private func updateTitle() {
        let date = self.dateFormatter.string(from: self.calendarDate)
        let attributedString = NSAttributedString(string: date, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28)]) 
        self.titleLabel.attributedText = attributedString
    }

    
    private func updateDays() {
        self.days.removeAll()
        let startDayOfTheWeek = self.startDayOfTheWeek()
        let totalDays = startDayOfTheWeek + self.endDate()
        
        for day in Int()..<totalDays {
            if day < startDayOfTheWeek {
                self.days.append(String())
                continue
            }
            self.days.append("\(day - startDayOfTheWeek + 1)")
        }
        
        self.collectionView.reloadData()
    }
    
    private func today() {
        let components = self.calendar.dateComponents([.year, .month], from: Date())
        self.calendarDate = self.calendar.date(from: components) ?? Date()
        self.updateCalendar()
    }
    
}

extension CalendarViewController {
    @objc private func didTodayButtonTouched(_ sender: UIButton) {
        self.today()
    }
    
}
