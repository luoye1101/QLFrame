//
//  TestOneViewController.swift
//  QL
//
//  Created by 黄跃奇 on 2017/12/9.
//  Copyright © 2017年 yueqi. All rights reserved.
//

import UIKit

class TestOneViewController: QLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.brown
        self.useRightItem = true
        
        self.title = "测试控制器"
        self.swipeEnabled = true
    }
}
