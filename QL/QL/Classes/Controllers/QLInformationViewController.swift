//
//  QLInformationViewController.swift
//  QL
//
//  Created by 黄跃奇 on 2017/12/9.
//  Copyright © 2017年 yueqi. All rights reserved.
//

import UIKit

class QLInformationViewController: QLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backItemImage = UIImage(named: "add")
        self.rightItemTitle = ""
        
        self.useRightItem = true
        self.rightItemImage = UIImage(named: "v3_contact_top-bar")
    }
    
    override func navBarButtonItemAction(sender: UIButton) {
        if sender == self.backBtnItem {
            print("左侧按钮")
            let vc = TestOneViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if sender == self.rightBtnItem {
            print("右侧按钮")
        }
    }
}
