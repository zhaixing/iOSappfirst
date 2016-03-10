//
//  OAuthViewController.swift
//  iOSDesign
//
//  Created by sam on 16/3/10.
//  Copyright © 2016年 sam. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

    let client_id = "1354359843"
    let redirect_uri="http://www.aikan66.com"
    //定义一个webView属性
    let webView=UIWebView()
    
    //MARK:监听方法
    @objc private func close(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func loadView() {
        view = webView
        print(view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        //加载网页配置
        loadOauthPage()
    }
    private func loadOauthPage(){
        let urlString="https://api.weibo.com/oauth2/authorize?"+"client_id="+client_id+"&redirect_uri="+redirect_uri
        let url=NSURL(string: urlString)
        let request=NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    private func setUpUI(){
    self.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "close")
    }
}
