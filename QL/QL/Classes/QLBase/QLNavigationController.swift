//
//  QLNavigationController.swift
//  QL
//
//  Created by 黄跃奇 on 2017/12/9.
//  Copyright © 2017年 yueqi. All rights reserved.
//

import UIKit

class QLNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var toAlpha: CGFloat?
    var fromAlpha: CGFloat?
    var duringPushAnimation: Bool?
    weak var realDelegate: UINavigationControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.delegate == nil) {
            self.delegate = self
        }
        
        self.interactivePopGestureRecognizer?.delegate = self
        self.interactivePopGestureRecognizer?.isEnabled = true
        
        // 监听侧滑手势交互过程
        self.interactivePopGestureRecognizer?.addTarget(self, action: #selector(handleNavigationTransition))
    }
    
    @objc func handleNavigationTransition(panGesture: UIPanGestureRecognizer) {
        // 计算偏移量
        let offsetX = panGesture.location(in: self.view).x
        let bgView = self.navigationBar.subviews.first

        if panGesture.state == UIGestureRecognizerState.began {
            
            weak var transitionContext: UIViewControllerTransitionCoordinator? = topViewController?.transitionCoordinator
            let toVC = transitionContext?.viewController(forKey: .to) as? QLBaseViewController
            toAlpha = toVC?.expectDisplayNavAlpha()
            transitionContext?.notifyWhenInteractionEnds({(_ context: UIViewControllerTransitionCoordinatorContext) -> Void in
                if context.isCancelled {
                    bgView?.alpha = self.fromAlpha!
                } else {
                    bgView?.alpha = self.toAlpha!
                }
            })
        } else {
            if panGesture.state == UIGestureRecognizerState.changed {
                if offsetX >= 0 {
                    let present = offsetX / self.view.bounds.size.width
                    bgView?.alpha = self.fromAlpha! + (self.toAlpha! - self.fromAlpha!) * present
                    print("导航控制器侧滑透明度 === %f", bgView?.alpha as Any)
                }
            }
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        //如果是根控制器，无侧滑
        if self == UIApplication.shared.delegate?.window??.rootViewController {
            print("根控制器")
            return false
        }
        
        //如果当前显示的控制器已经是栈顶控制器了，不需要做任何切换动画
        if self.visibleViewController == self.viewControllers.first {
            print("栈底控制器")
            return false
        }
        
        //转场中
        if self.duringPushAnimation! {
            print("转场中")
            return false
        }
        
        let bgView = self.navigationBar.subviews.first
        self.fromAlpha = bgView?.alpha
        
        return true
    }

    // 重写该方法监听push的子视图控制及导航视图控制器里面有几个子视图控制器
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        print("子视图控制器:--\(viewControllers.count)--\(viewControllers)")
        self.duringPushAnimation = true
        // 如果个数大于0表示不是根视图控制器
        if viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        } else {
            viewController.hidesBottomBarWhenPushed = false
        }
        super.pushViewController(viewController, animated: true)
    }
    
    // 重写pop方法
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        return super.popToViewController(viewController, animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return super.popToRootViewController(animated: animated)
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.duringPushAnimation = false
        print("当前vc === \(viewController.self)")
        if (realDelegate != nil) && (realDelegate?.responds(to: #function))! {
            // 切换回真正的代理去执行代理方法
            realDelegate?.navigationController!(navigationController, didShow: viewController, animated: animated)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if (realDelegate != nil) && (realDelegate?.responds(to: #function))! {
            // 切换回真正的代理去执行代理方法
            realDelegate?.navigationController!(navigationController, willShow: viewController, animated: animated)
        }
    }
    
    deinit {
        self.delegate = nil
        self.interactivePopGestureRecognizer?.delegate = nil
    }
}























