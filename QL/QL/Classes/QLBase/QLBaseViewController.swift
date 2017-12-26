//
//  QLBaseViewController.swift
//  QL
//
//  Created by 黄跃奇 on 2017/12/9.
//  Copyright © 2017年 yueqi. All rights reserved.
//  基类

import UIKit

class QLBaseViewController: UIViewController {
    
    /// 导航栏左侧按钮
    var backBtnItem: UIButton?
    /// 导航栏右侧按钮
    var rightBtnItem: UIButton?
    
    /// 导航栏右侧按钮是否为灰度,不可点击
    var useGrayItem: Bool? {
        didSet {
            if useGrayItem! {
                self.rightBtnItem?.setTitleColor(UIColor.lightGray, for: .normal)
                self.rightBtnItem?.setTitleColor(UIColor.lightGray, for: .highlighted)
                self.rightBtnItem?.isUserInteractionEnabled = false
            } else {
                self.rightBtnItem?.setTitleColor(RGB(r: 51, g: 51, b: 51), for: .normal)
                self.rightBtnItem?.setTitleColor(UIColor.lightGray, for: .highlighted)
                self.rightBtnItem?.isUserInteractionEnabled = true
            }
        }
    }
    
    /// 右滑 --- 子类viewDidAppear中关闭
    var swipeEnabled: Bool? {
        didSet {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = swipeEnabled!
        }
    }
    
    /// 是否显示返回按钮
    var useBackItem: Bool? {
        didSet {
            if useBackItem == false {
                self.backBtnItem?.setTitle("", for: .normal)
                self.backBtnItem?.setImage(nil, for: .normal)
                self.backBtnItem?.isEnabled = false
            } else {
                if (self.backBtnItem != nil) {
                    self.backBtnItem?.isEnabled = true
                } else {
                    self.backBtnItem = UIButton(type: .custom)
                    self.backBtnItem?.frame = CGRect(x: 0, y: 0, width: 45.0, height: 40.0)
                    self.backBtnItem?.setImage(UIImage(named: "All_back_button"), for: .normal)
                    self.backBtnItem?.addTarget(self, action: #selector(self.navBarButtonItemAction), for: .touchUpInside)
                    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.backBtnItem!)
                }
            }
        }
    }
    
    /// 导航栏右按钮标题
    var rightItemTitle: String? {
        didSet {
            self.rightBtnItem?.setAttributedTitle(nil, for: .normal)
            if (rightItemTitle != nil) {
                if !self.useRightItem! {
                    self.useRightItem = true
                }
                self.rightBtnItem?.setAttributedTitle(nil, for: .normal)
                self.rightBtnItem?.setTitle(rightItemTitle, for: .normal)
                self.rightBtnItem?.setTitle(rightItemTitle, for: .highlighted)
                self.rightBtnItem?.setTitle("", for: .selected)
                self.rightBtnItem?.setTitleColor(RGB(r: 51, g: 51, b: 51), for: .normal)
                self.rightBtnItem?.setTitleColor(UIColor.lightGray, for: .highlighted)
            } else {
                self.rightBtnItem?.setTitle("", for: .normal)
                self.rightBtnItem?.setTitle("", for: .highlighted)
            }
        }
    }
    
    var rightItemAttributedTitle: NSAttributedString? {
        didSet {
            self.rightBtnItem?.setAttributedTitle(rightItemAttributedTitle, for: .normal)
            if (rightItemAttributedTitle != nil) {
                if !useRightItem! {
                    useRightItem = true
                }
            } else {
                self.rightBtnItem?.setTitle("", for: .normal)
                self.rightBtnItem?.setTitle("", for: .highlighted)
            }
        }
    }
    
    /// 导航栏右按钮图片
    var rightItemImage: UIImage? {
        didSet {
            if !self.useRightItem! {
                self.useRightItem = true
            }
            let imgSize: CGSize = rightItemImage!.size
            let ratio: CGFloat = imgSize.width / imgSize.height
            if imgSize.width > (rightBtnItem?.frame.width)! || imgSize.height > (rightBtnItem?.frame.width)! {
                var newFrame: CGRect = rightBtnItem!.frame
                let newWidth: CGFloat = rightBtnItem!.bounds.height * ratio
                newFrame = CGRect(x: newFrame.maxX - newWidth, y: newFrame.origin.y, width: newWidth, height: newFrame.size.height)
                rightBtnItem?.frame = newFrame
                rightBtnItem?.contentHorizontalAlignment = .right
            }
            self.rightBtnItem?.setImage(rightItemImage, for: .normal)
        }
    }
    
    /// 导航栏返回按钮图片
    var backItemImage: UIImage? {
        didSet {
            self.backBtnItem?.setImage(backItemImage, for: .normal)
        }
    }
    
    /// 是否使用导航栏右按钮
    var useRightItem: Bool? {
        didSet {
            if !useRightItem! {
                self.rightBtnItem?.setTitle("", for: .normal)
                self.rightBtnItem?.isEnabled = false
                self.rightBtnItem?.isUserInteractionEnabled = true
            } else {
                self.rightBtnItem?.isEnabled = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI() {
        print("\(self))")
        self.view.backgroundColor = RGB(r: 239, g: 239, b: 244)
        
        // 导航栏左侧按钮
        let backImage = UIImage(named: "All_back_button")
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 44))
        self.backBtnItem = UIButton(type: .custom)
        self.backBtnItem?.frame = CGRect(x: 0, y: 0, width: backView.bounds.width, height: backView.bounds.height)
        self.backBtnItem?.isExclusiveTouch = true
        self.backBtnItem?.setImage(backImage, for: .normal)
        self.backBtnItem?.contentHorizontalAlignment = .left
        self.backBtnItem?.addTarget(self, action: #selector(navBarButtonItemAction), for: .touchUpInside)
        backView.addSubview(self.backBtnItem!)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backView)
        
        // 导航栏右侧按钮
        self.rightBtnItem = UIButton(type: .custom)
        self.rightBtnItem?.frame = CGRect(x: 0, y: 0, width: backView.bounds.width, height: backView.bounds.height)
        self.rightBtnItem?.isExclusiveTouch = true
        let opacityImage = UIImage(named: "")
        self.rightBtnItem?.setBackgroundImage(opacityImage, for: .highlighted)
        self.rightBtnItem?.contentHorizontalAlignment = .right
        self.rightBtnItem?.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        self.rightBtnItem?.addTarget(self, action: #selector(navBarButtonItemAction), for: .touchUpInside)
        backView.addSubview(self.rightBtnItem!)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightBtnItem!)
        
        if navigationController?.interactivePopGestureRecognizer?.delegate == nil {
            navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        }
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        self.useRightItem = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.setAnimationsEnabled(true)
        if navigationController?.navigationBar.isHidden != nil {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    /// 导航栏按钮点击事件
    @objc func navBarButtonItemAction(sender: UIButton) {
        
        if sender.isEqual(self.backBtnItem) && !(self.backBtnItem?.isSelected)! {
            self.backBtnItem?.isSelected = true
            
            print("导航栏左侧按钮")
            
            let vc = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
            if (vc?.presentedViewController != nil) {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            if (rightBtnItem!.title(for: .selected) != nil) && !(rightBtnItem!.title(for: .selected) == "") || (rightBtnItem!.image(for: .selected) != nil) {
                rightBtnItem?.isSelected = !rightBtnItem!.isSelected
            }
        }
    }
    
    func expectDisplayNavAlpha() -> CGFloat {
        return 1.0;
    }
}













