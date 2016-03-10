//
//  BaseTableViewController.swift
//  iOSDesign
//
//  Created by sam on 16/3/6.
//  Copyright © 2016年 sam. All rights reserved.
//

import UIKit

//协议中方法是必选的，如果不实现就报错
class BaseTableViewController: UITableViewController,VisitorLoginViewDelegate {//面试题oc中没有继承，是用什么替代的？用协议

    //添加用户是否登录的标记
    var userLogin = false
    var visitorLoginView:VisitorLoginView?
    
    //loadview是苹果专门为 手写代码准备的，等于sb/xib
    //一旦使用这个方法 sb/xib 就自动失效
    //会自动检测view是否为空，如果为空，就自动调用loadView方法
    
    override func loadView() {
        
        userLogin ? super.loadView() : loadVisitorView()
        /*三目预算符 如上一行
        //自动去调用tableView
        super.loadView()//真正进入的主页等页面，已经登录成功
        
        //下面的四行代码是调用自己定义的view
        let v=UIView()
        v.backgroundColor=UIColor.redColor()
        view=v
        print(view)
        */
    }
    
    private func loadVisitorView(){//红色验证的页面，需要用户去登录的引导界面
//        let v=UIView()
//        v.backgroundColor=UIColor.redColor()
//        view=v
//        print(view)
        //上面四行代码是测试用的，证明我创建好了一个可以自己定义的用户验证界面
        //下面是具体的实现，VisitorLoginView()继承自UIView()
//        let v=VisitorLoginView()
//        view=v
        
        visitorLoginView = VisitorLoginView()
        
        //设置代理,去下面第一个括号后面实现
        visitorLoginView?.visitorDelegate=self
        
        
        view = visitorLoginView
        //然后把精力集中在VisitorLoginView这个class里面
        
        //左上角的登录，右上角的注册
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "visitorWillRegistor")
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "登录", style: .Plain, target: self, action: "visitorWillLogin")
        //设置上面登录注册的颜色

    }
    
//    xmark:visitorDelegate 协议方法
    func visitorWillLogin() {
        print("come out")
        let oauth=OAuthViewController()
        let nav = UINavigationController(rootViewController: oauth)
        presentViewController(nav, animated: true, completion: nil)
    }
    
    func visitorWillRegistor() {
        print("come in")
    }
    
    //视图控制器 viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


}
