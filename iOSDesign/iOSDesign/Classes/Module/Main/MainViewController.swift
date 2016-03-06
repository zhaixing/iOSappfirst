//
//  MainViewController.swift
//  iOSDesign
//
//  Created by sam on 16/3/5.
//  Copyright © 2016年 sam. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    //添加子视图控制器
    addChildViewControllers()
    }
    private  func addChildViewControllers() {
        let home=HomeTableViewController()
        
        //实例化导航控制器
        let nav=UINavigationController(rootViewController: home)
        
        //设置首页标题
        home.title="首页"
        //添加
        addChildViewController(nav)
    }
}
