//
//  MainViewController.swift
//  iOSDesign
//
//  Created by sam on 16/3/5.
//  Copyright © 2016年 sam. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    @objc private func composeDidClick(){ //加上private会安全点，但是有个别的问题需要加上@objc。。兼容o-c机制了。。。
        print( __FUNCTION__ )//打印方法名
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //由于tabbar是只读 不能直接操作，如果要修改 可以使用KVC
        let mainTabBar = MainTabBar()
        //KVC赋值
        setValue(mainTabBar, forKey: "tabBar")
        
        //添加子视图控制器
        addChildViewControllers()
        
        //测试语句，打印出类名，看程序是否执行到   classForCoder打印函数的类名
        print(tabBar.classForCoder)
        
        //设置点击事件
        mainTabBar.composeBtn.addTarget(self, action: "composeDidClick", forControlEvents: .TouchUpInside)//相应事件composeDidClick很重要，习惯写在上面
    }
    
    private  func addChildViewControllers() {
/*里面的内容用到了5次，我要写一个方法。系统本身有这个方法，所以我重载一个
        let home=HomeTableViewController()
        
        //实例化导航控制器
        let nav=UINavigationController(rootViewController: home)
        
        //设置首页标题
        home.title="首页"
        
        //设置首页tablebar
        home.tabBarItem.image=UIImage(named: "tabbar_home")
        
        //添加
        addChildViewController(nav)
*/
        //写完重载方法（在下面），之后调用5次
        addChildViewController(HomeTableViewController(), title: "首页", imageName : "tabbar_home")
        addChildViewController(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
    }
    
    //重载方法
    private func addChildViewController(vc:UIViewController,title:String,imageName:String){
        
        //设置点击后字体的颜色 查找点
//        self.tabBar.tintColor = UIColor.init(red: 70/255.0, green: 200/255.0, blue: 202/255.0, alpha: 1.0)
        self.tabBar.tintColor = UIColor.orangeColor()
        let nav = UINavigationController(rootViewController: vc)
        vc.title=title
        vc.tabBarItem.image=UIImage(named: imageName)
        addChildViewController(nav)
    }
}
