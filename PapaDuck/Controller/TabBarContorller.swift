//
//  TabBarContorller.swift
//  KickBoardApp
//
//  Created by 전성진 on 7/22/24.
//

import UIKit

class TabBarContorller: UITabBarController {
    
    lazy var mainController: UINavigationController = {
        let controller = MainController()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        navigationController.tabBarItem.title = "메인페이지"
        return navigationController
    }()
    
    lazy var mypageController: UINavigationController = {
        let controller = MypageViewController()
        let navigationController = UINavigationController(rootViewController: (controller))
        navigationController.tabBarItem.image = UIImage(systemName: "person.fill")
        navigationController.tabBarItem.title = "마이페이지"
        controller.view.backgroundColor = .white
        return navigationController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [mainController, mypageController]
    }
}
