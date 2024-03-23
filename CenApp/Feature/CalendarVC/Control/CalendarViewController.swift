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

class CalendarViewController: UIViewController, UITableViewDelegate {
    private let calendarTableViewDelegate = CalendarTableViewDelegate()
    private let calendarTableViewDatasource = CalendarTableViewDataSource()
    var isSelectedCell = false // 선택 여부를 추적하는 변수
    var selectedIndexPath: IndexPath?
    var scholarships: [CalendarModel] = [] // 장학금 데이터 배열
    var endData : [CalendarEndModel] = []
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
        view.backgroundColor = .PrimaryColor2
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
        setTable()
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = String(format: "%02d", calendar.component(.month, from: currentDate))
        view.backgroundColor = .white
        addSubviews()
        configure()
        configUI()
        //MARK: -- API 호출
        CalendarAPI.fetchMonthData(year: String(year), month: month,completion: { [weak self] scholarships in
            guard let self = self, let scholarships = scholarships else {return}
            calendarTableViewDatasource.scholarships = scholarships
            calendarTableViewDelegate.scholarships = scholarships
            DispatchQueue.main.async {
                print("tableview didload")
                self.calendartTableView.reloadData() // 테이블 뷰 데이터 리로드
                
            }
        },onError: {error in
            print("Error fetching scholarships: \(error)")
        })
        
        CalendarCountAPI.fetchMonthData(year: String(year), month: month, completion: { [weak self] endData in
            guard let self = self, let endData = endData else {
                // 서버에서 데이터를 받아오지 못한 경우
                // 모든 셀의 Circle View를 숨김
                return
            }
            print("endData", endData)
            
            DispatchQueue.main.async {
                // 월별 데이터가 있을 때
                // 모든 셀의 Circle View를 숨김
                for cell in self.collectionView.visibleCells {
                    if let calendarCell = cell as? CalendarCollectionViewCell {
                        calendarCell.circleView.isHidden = true
                    }
                }
                
                // 월별 데이터가 있을 때 각 날짜에 대해 Circle View를 추가
                for date in endData {
                    print("CircleDate: \(date)")
                    let components = date.split(separator: "-")
                    guard let day = components.last else {
                        print("Failed to extract day from date: \(date)")
                        continue
                    }
                    print("Day: \(day)")
                    let dayString = String(day)
                    
                    // 날짜에 해당하는 인덱스 찾기
                    if let index = self.days.firstIndex(of: dayString) {
                        // 인덱스에 해당하는 셀 업데이트
                        if let cell = self.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? CalendarCollectionViewCell {
                            // 업데이트된 날짜와 셀의 일치 여부 확인 후 Circle view 표시
                                cell.circleView.isHidden = false // Circle view를 표시
                            
                        }
                    }
                }
                
                print("Success")
            }
        }, onError: { error in
            print("Error fetching scholarships: \(error)")
        })
    }
    func setTable() {
        calendartTableView.delegate = calendarTableViewDelegate
        calendartTableView.dataSource = calendarTableViewDatasource
    }
    func configure() {
        configureTitleLabel()
        configureWeekStackView()
        configureWeekLabel()
        //configureTableView()
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
        //서버 호출
        //MARK: -- API 호출 2
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = String(format: "%02d", calendar.component(.month, from: currentDate))
        //이전에 선택한 셀
        if let previousSelectedIndexPath = selectedIndexPath {
                if let previousSelectedCell = collectionView.cellForItem(at: previousSelectedIndexPath) as? CalendarCollectionViewCell {
                        previousSelectedCell.backgroundColor = .white // 원래의 배경색으로 변경
            }
            
            if previousSelectedIndexPath == indexPath {
                collectionView.deselectItem(at: indexPath, animated: true)
                // 선택된 인덱스 패스를 nil로 설정하여 선택 취소를 나타냅니다
                selectedIndexPath = nil
                
                CalendarAPI.fetchMonthData(year: String(year), month: month,completion: { [weak self] scholarships in
                    guard let self = self, let scholarships = scholarships else {return}
                    calendarTableViewDatasource.scholarships = scholarships
                    calendarTableViewDelegate.scholarships = scholarships
                    DispatchQueue.main.async {
                        print("tableview didload")
                        self.calendartTableView.reloadData() // 테이블 뷰 데이터 리로드
                        
                    }
                },onError: {error in
                    print("Error fetching scholarships: \(error)")
                })
                // 선택된 셀의 배경색을 초기화합니다
                if let selectedCell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell {
                    selectedCell.backgroundColor = .white
                    
                }
                
                // 선택 취소 후 추가 작업이 필요한 경우에는 여기에 작성합니다
                return
            }
        }
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
                //셀 선택시 api 호출
                CalendarDayAPI.fetchMonthData(year: String(year),month: month,day: String(day),completion: { [weak self] scholarships in
                    guard let self = self, let scholarships = scholarships else {return}
                    calendarTableViewDatasource.scholarships = scholarships
                    calendarTableViewDelegate.scholarships = scholarships
                    DispatchQueue.main.async {
                        print("tableview didload")
                        self.calendartTableView.reloadData() // 테이블 뷰 데이터 리로드
                        
                    }
                },onError: {error in
                    print("Error fetching scholarships: \(error)")
                })
                selectedIndexPath = indexPath

            }
    }
    /// didDeselectItemAt

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
    func ingButtonDidTap(in cell: CalendarTableViewCell, at indexPath: IndexPath) {
        
    }
    
    func ingViewDidTap() {
        
    }
}
//MARK: - TableViewDelegate, TableViewDataSource
extension CalendarViewController  {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CalendarTableViewCell.identifier, for: indexPath) as! CalendarTableViewCell
        cell.delegate = self //델리게이트 설정
        return cell
    }
    func updateCircleCount(forDate date: String) {
           print("CircleDate: \(date)")
           let components = date.split(separator: "-")
           guard let day = components.last else {
               print("Failed to extract day from date: \(date)")
               return
           }
           print("Day: \(day)")
           let dayString = String(day)
           for (index, cellDate) in days.enumerated() {
               if cellDate == dayString {
                   if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? CalendarCollectionViewCell {
                       cell.circleView.isHidden = false // Circle view를 표시
                   }
               }
           }
       }
}

extension CalendarViewController {
    @objc private func refreshData() {
        refreshIndicator.endRefreshing()
        setTable()
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = String(format: "%02d", calendar.component(.month, from: currentDate))
        CalendarAPI.fetchMonthData(year: String(year), month: month,completion: { [weak self] scholarships in
            guard let self = self, let scholarships = scholarships else {return}
            calendarTableViewDatasource.scholarships = scholarships
            calendarTableViewDelegate.scholarships = scholarships
            DispatchQueue.main.async {
                print("tableview didload")
                self.calendartTableView.reloadData() // 테이블 뷰 데이터 리로드
                
            }
        },onError: {error in
            print("Error fetching scholarships: \(error)")
        })
    }
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
