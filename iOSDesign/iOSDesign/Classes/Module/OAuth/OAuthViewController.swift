//
//  OAuthViewController.swift
//  iOSDesign
//
//  Created by sam on 16/3/10.
//  Copyright © 2016年 sam. All rights reserved.
//

import UIKit

//加载进度条
import SVProgressHUD
import AFNetworking

class OAuthViewController: UIViewController {

    let client_id = "1354359843"
    let redirect_uri="http://www.aikan66.com"
    let client_secret="4252aef11ef0e281ff934841ad715287"
    //定义一个webView属性
    let webView=UIWebView()
    
    //MARK:监听方法
    @objc private func close(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func fullAccount(){
        
        //自动填充账号，密码执行js代码
        let jsString = "document.getElementById('userId').value='18633848128',document.getElementById('passwd').value='woaiwodejia';"
        webView.stringByEvaluatingJavaScriptFromString(jsString)
        
    }
    override func loadView() {
        view = webView
        webView.delegate=self
//        print(view)
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
    self.navigationItem.rightBarButtonItem=UIBarButtonItem(title: "自动填充", style: .Plain, target: self, action: "fullAccount")
    }
}

//引入代理 专门处理web所有的 协议方法
extension OAuthViewController:UIWebViewDelegate{
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    //协议方法如果返回true表示当前协议正常工作
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        print(request.URL)

//        let urlString = request.URL?.absoluteString
//        print(urlString)

//        let urlString = request.URL?.absoluteString
//        if urlString?.hasPrefix("https://api.weibo.com/"){
//            return true
//        }
//        //这里因为URLString是可选的，所以用一下方法实现


        guard let urlString = request.URL?.absoluteString else{
            return false
        }//此时urlString里面一定有值
        
        //是网页请求页面，或者请求授权页面
        if urlString.hasPrefix("https://api.weibo.com/") {
            return true
        }
        
        if !urlString.hasPrefix(redirect_uri){
            return false
        }
        //程序走到这里，一定包含了回调的url
//        print(urlString) 此时程序走到字符串http://www.aikan66.com/就停止了  输出结果http://www.aikan66.com/Optional("code=7d3acbd8eee45586a2ca767573d5b64c")
        
        //取里面的字符串
//        let query=request.URL?.query
//        print(query)   //输出结果 Optional("code=7d3acbd8eee45586a2ca767573d5b64c")
        
        //既然上面3行的结果是可选的，那么guard一下
        guard let query=request.URL?.query else {
            return false
        }
        
        let codeStr="code="
        let code = query.substringFromIndex(codeStr.endIndex)
        print(query)
        print(code)
        
        //执行下面的方法
        loadAccessToken(code)
        
        return false
    }
    
    //抽出来一个方法，这个方法取令牌token
    private func loadAccessToken(code:String){
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let parameters=["client_id":client_id,"client_secret":client_secret,"grant_type":"authorization_code","code":code,"redirect_uri":redirect_uri]
        let AFN=AFHTTPSessionManager()
        //这里有个常见错误，Request failed: unacceptable content-type: text/plain" 
        //AFN这个第三方框架默认支持：@"application/json", @"text/json", @"text/javascript"
        //需要用下面的一句话做转换
        AFN.responseSerializer.acceptableContentTypes?.insert("text/plain")
        AFN.POST(urlString, parameters: parameters, success: { (_, result) -> Void in
//            print(result)
//            看到结果
//            Optional({
//            "access_token" = "2.006JlN6DbrkeTBe3236d6b9cq6VZNC";
//            "expires_in" = 157679999;
//            "remind_in" = 157679999;
//            uid = 3121086411;
//        })
            
            //上面的结果已经输出在控制台，下面把他接收到自己的ios程序里面，并使用数据
            
            if let dict=result as? [String:AnyObject]{
                
                //插入： 这是字典转模型，从生成的用户类需要内容填充
                let account=UserAccount(dict: dict)
                print(account)
                
                let access_token = dict["access_token"] as? String //强制类型转换
                let uid = dict["uid"] as? String
                
                //相信后端一定能给到数据，所以加！
                self.loadUserInfo(access_token!,uid:uid!)
            }
            
            }) { (_, error) -> Void in
                print(error)
        }
    }
    
    private func loadUserInfo(access_token:String,uid:String){
        let urlString = "https://api.weibo.com/2/users/show.json"
        let parameters = ["access_token":access_token,"uid":uid]
        let AFN = AFHTTPSessionManager()
        AFN.GET(urlString, parameters: parameters, success: { (_, result) -> Void in
            print(result)
            }) { (_, error) -> Void in
                error
        }
    }
}
