//
//  LocationViewController.swift
//  CenApp
//
//  Created by 김민솔 on 3/17/24.
//

import UIKit
import Then
import SnapKit
import iOSDropDown


class LocationViewController: CustomProgressViewController {
    let dropdown = DropDown()
    
    let locationDropdown = DropDown()
    let locations = ["서울","경기","인천","강원","대전","세종","충남","충북","부산","울산","경남","경북","대구","광주","전남","전북","제주"]
    let seoulState = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"]
    let keyongkiState = ["가평군","고양시 덕양구","고양시 일산동구","고양시 일산서구","과천시","광명시","광주시","구리시","군포시",
    "김포시","남양주시","동두천시","부천시 소사구","부천시 오정구","부천시 원미구","성남시 분당구","성남시 수정구","성남시 중원구",
    "수원시 권선구","수원시 영통구","수원시 장안구","수원시 팔달구","시흥시","안산시 단원구","안산시 상록구","안성시",
                         "안양시 동안구","안양시 만안구","양주시","양평군","여주시","연천군","오산시","용인시 기흥구","용인시 수지구","용인시 처인구","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시"]
    let incheonState = ["강화군","계양구","남동구","동구","미추홀구","부평구","서구","연수구","옹진군","중구"]
    let kangwonState = ["강릉시","고성군","동해시","삼척시","속초시","양구군","양양군","영월군","원주시","인제군","정선구","철원군","춘천시","태백시","평창군","홍천군","화천군","횡성군"]
    let daegeonState = ["대덕구","동구","서구","유성구","중구"]
    let sejongState = ["세종시"]
    let cheungnamState = ["계룡시","공주시","금산군","논산시","당진시","보령시","부여군","서산시","서천군","아산시","예산군",
    "천안시","청양군","태안군","홍성군"]
    let chungbookState = ["괴산군","단양군","보은군","영동군","옥천군","음성군","제천시","증평군","진천군","청주시 상당구","청주시 서원구","청주시 청원구","청주시 홍덕구","충주시"]
    let busanState = ["강서구","금정구","기장군","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구"]
    let ulsanState = ["남구","동구","북구","울주군","중구"]
    let gyeongnamState = ["거제시","거창군","고성군","김해시","남해군","밀양시","사천시","산청군","양산시","의령군","진주시","창녕군",
    "창원시 마산합포구","창원시 마산회원구","창원시 성산구","창원시 의창구","창원시 진해구","통영시","하동군","함안군","함양군","합천군"]
    let gyeongbukState = ["경산시","경주시","고령군","구미시","김천시","문경시","봉화군","상주시","성주군","안동시","영덕군",
    "영양군","영주시","영천시","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군","포항시 남구","포항시 북구"]
    let daeguState = ["군위군","남구","달서구","달성군","동구","북구","서구","수성구","중구"]
    let gwangjuState = ["광산구","남구","동구","북구","서구"]
    let jeonnamState = ["강진군","고흥군","곡성군","광양시","구례군","나주시","담양군","목포시","무안군","보성군","순천시","신안군",
    "여수시","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"]
    let jeonbukState = ["고창군","군산시","김제시","남원시","무주군","부안군","순창군","완주군","익산시","임실군","장수군"
    ,"전주시 덕진구","전주시 완산구","정읍시","진안군"]
    let jejuState = ["서귀포시","제주시"]
    //MARK: -- UI Component
    private let progressLabel = UILabel().then {
        $0.text = "4/4"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    private let lcoationChoiceLabel = UILabel().then {
        $0.text = "거주지역을 선택해주세요"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    private let horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 15
    }
    private let firstLocationView = UIView().then {
        $0.backgroundColor = UIColor.ThirdaryColor
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let secondLocationView = UIView().then {
        $0.backgroundColor = UIColor.ThirdaryColor
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.backgroundColor = UIColor.SecondaryColor
        $0.setTitleColor(.gray, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgressBar(progress: 4/4)
        addSubviews()
        configUI()
        setupDropdown()
        setupLocationDropdown()
        view.backgroundColor = .white
        
    }
    func addSubviews() {
        view.addSubview(progressLabel)
        view.addSubview(lcoationChoiceLabel)
        view.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(firstLocationView)
        horizontalStackView.addArrangedSubview(secondLocationView)
        firstLocationView.addSubview(dropdown)
        secondLocationView.addSubview(locationDropdown)
        view.addSubview(nextButton)
    }
    func configUI() {
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.centerX.equalToSuperview()
        }
        lcoationChoiceLabel.snp.makeConstraints {
            $0.top.equalTo(progressLabel.snp.bottom).offset(75)
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
        }
        horizontalStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(lcoationChoiceLabel.snp.bottom).offset(60)
        }
        firstLocationView.snp.makeConstraints {
            $0.width.equalTo(130)
        }
        dropdown.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        secondLocationView.snp.makeConstraints {
            $0.width.equalTo(130)
        }
        locationDropdown.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        nextButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
    func setupDropdown() {
        dropdown.optionArray = locations
        dropdown.isSearchEnable = false
        dropdown.text = "시/도"
        dropdown.font = UIFont.systemFont(ofSize: 14)
        dropdown.textColor = UIColor.black
        dropdown.selectedRowColor = UIColor.PrimaryColor
        dropdown.arrowSize = 10
        dropdown.checkMarkEnabled = false
        dropdown.backgroundColor = UIColor.ThirdaryColor
        // 선택한 항목에 대한 이벤트 처리
        dropdown.didSelect { [weak self] (selectedItem, index, id) in
            print("Selected item: \(selectedItem) at index: \(index)")
                   
        }
    }
    func setupLocationDropdown() {
        locationDropdown.isSearchEnable = false
        locationDropdown.text = "시/군/구"
        locationDropdown.font = UIFont.systemFont(ofSize: 12)
        locationDropdown.textColor = UIColor.black
        locationDropdown.selectedRowColor = UIColor.PrimaryColor
        locationDropdown.arrowSize = 10
        locationDropdown.checkMarkEnabled = false
        locationDropdown.backgroundColor = UIColor.ThirdaryColor
        // 선택한 항목에 대한 이벤트 처리
        locationDropdown.didSelect { [weak self] (selectedItem, index, id) in
            print("Selected item: \(selectedItem) at index: \(index)")
            self?.nextButton.backgroundColor = UIColor.PrimaryColor
            self?.nextButton.setTitleColor(.white, for: .normal)
        }
        // 시/도 선택 시 해당 시/도의 시/군/구 목록을 설정
        dropdown.didSelect { [weak self] (selectedItem, index, id) in
            guard let self = self else { return }
            switch selectedItem {
            case "서울":
                locationDropdown.optionArray = self.seoulState
            case "경기":
                locationDropdown.optionArray = self.keyongkiState
            case "인천":
                locationDropdown.optionArray = self.incheonState
            case "강원":
                locationDropdown.optionArray = self.kangwonState
            case "대전":
                locationDropdown.optionArray = self.daegeonState
            case "세종":
                locationDropdown.optionArray = self.sejongState
            case "충남":
                locationDropdown.optionArray = self.cheungnamState
            case "충북":
                locationDropdown.optionArray = self.chungbookState
            case "부산":
                locationDropdown.optionArray = self.busanState
            case "울산":
                locationDropdown.optionArray = self.ulsanState
            case "경남":
                locationDropdown.optionArray = self.gyeongnamState
            case "경북":
                locationDropdown.optionArray = self.gyeongbukState
            case "대구":
                locationDropdown.optionArray = self.daeguState
            case "광주":
                locationDropdown.optionArray = self.gwangjuState
            case "전남":
                locationDropdown.optionArray = self.gyeongnamState
            case "전북":
                locationDropdown.optionArray = self.gyeongbukState
            case "제주":
                locationDropdown.optionArray = self.jejuState
            default:
                locationDropdown.optionArray = []
            }
            
        }
    }
    @objc func nextButtonTapped(_ sender: UIButton) {
        let finishVC = FinishViewController()
        self.navigationController?.pushViewController(finishVC, animated: true)
    }
}
