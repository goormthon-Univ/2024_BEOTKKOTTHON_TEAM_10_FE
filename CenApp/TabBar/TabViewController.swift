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
        self.LoginCheck() //로그인 확인
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // HomeViewController 생성 및 탭바 아이템 설정
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "House"), selectedImage: nil)
        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        
        // CalendarViewController 생성 및 탭바 아이템 설정
        let calendarVC = CalendarViewController()
        calendarVC.tabBarItem = UITabBarItem(title: "일정", image: UIImage(named: "Date"), selectedImage: nil)
        let calendarNavigationController = UINavigationController(rootViewController: calendarVC)
        
        // ListViewController 생성 및 탭바 아이템 설정
        let listVC = AnnoucementViewController(order: "마감순")
        listVC.tabBarItem = UITabBarItem(title: "공고 리스트", image: UIImage(named: "list"), selectedImage: nil)
        let listNavigationController = UINavigationController(rootViewController: listVC)
        
        // DocumentViewController 생성 및 탭바 아이템 설정
        let documentVC = DocumentViewController()
        documentVC.tabBarItem = UITabBarItem(title: "서류", image: UIImage(named: "Layer"), selectedImage: nil)
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
}
