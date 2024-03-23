//
//  TabViewController.swift
//  CenApp
//
//  Created by 김민솔 on 3/19/24.
//

import UIKit

class TabViewController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginCheck()
        // HomeViewController 생성 및 탭바 아이템 설정
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "House"), selectedImage: UIImage(named: "blueHouse"))
        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        
        // CalendarViewController 생성 및 탭바 아이템 설정
        let calendarVC = CalendarViewController()
        calendarVC.tabBarItem = UITabBarItem(title: "일정", image: UIImage(named: "Date"), selectedImage: UIImage(named: "blueDate"))
        let calendarNavigationController = UINavigationController(rootViewController: calendarVC)
        
        // AnnoucementViewController 생성 및 탭바 아이템 설정
        let listVC = AnnoucementViewController(order: "마감순")
        listVC.tabBarItem = UITabBarItem(title: "공고 리스트", image: UIImage(named: "list"), selectedImage: UIImage(named: "blueList"))
        let listNavigationController = UINavigationController(rootViewController: listVC)
        
        // DocumentViewController 생성 및 탭바 아이템 설정
        let documentVC = DocumentViewController()
        documentVC.tabBarItem = UITabBarItem(title: "서류", image: UIImage(named: "Layer"), selectedImage: UIImage(named: "blueLayer"))
        let documentNavigationController = UINavigationController(rootViewController: documentVC)
        
        // 탭바에 뷰 컨트롤러들을 설정
        viewControllers = [homeNavigationController, calendarNavigationController, listNavigationController, documentNavigationController]
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}
//MARK: - LoginCheckConnection
extension TabViewController {
    private func LoginCheck() {
        LoginCheckService.requestLogin { result in
            if let message = result?.message {
                if message == "login" {
                    return
                }
            }
        } onError: { error in
            LogoutService.requestLogout()
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
    private func fetchDeviceToken() {
        DeviceTokenService.requestDeviceToken { result in
            if let message = result.message {
                if message == "success" {
                    return
                }
            }
        } onError: { error in
            
        }
    }
}
