//
//  HomeTableViewController.swift
//  iOSDesign
//
//  Created by sam on 16/3/5.
//  Copyright © 2016年 sam. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        visitorLoginView?.setUIInfo(nil,title:"移动办公，随时随地")
        
        }
    func demo(){//测试学习使用导入的框架
        //filed:unacceptable content-type:text/html
        //使用AFN最常见问题  没有之一。
        let AFN = AFHTTPSessionManager()
        SVProgressHUD.show()
        AFN.responseSerializer.acceptableContentTypes?.insert("text/html")
        AFN.GET("http://www.weather.com.cn/data/sk/101010100.html", parameters: nil, success: { (task, result) -> Void in
            print(result)
            SVProgressHUD.dismiss()
            }) { (_, error) -> Void in
                print(error)
                SVProgressHUD.showErrorWithStatus("网络连接失败")
        }

    }

}
