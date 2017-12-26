//
//  QLTabBarController.swift
//  QL
//
//  Created by 黄跃奇 on 2017/12/9.
//  Copyright © 2017年 yueqi. All rights reserved.
//

import UIKit

class QLTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(childController: QLHomeViewController(), title: "首页", imageName: "Home_home_icon")
        addChildViewController(childController: QLInformationViewController(), title: "消息", imageName: "Home_information_icon")
        addChildViewController(childController: QLContactViewController(), title: "联系人", imageName: "Home_contact_icon")
        addChildViewController(childController: QLMineViewController(), title: "我", imageName: "Home_me_icon")
    }
    
    func addChildViewController(childController: UIViewController, title: String, imageName: String) {
        childController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: "\(imageName)_fill")?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.orange], for: .selected)
        childController.title = title
        let nav = QLNavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
}




























