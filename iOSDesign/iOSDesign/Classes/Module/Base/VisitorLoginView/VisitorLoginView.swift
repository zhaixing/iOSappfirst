//
//  VisitorLoginView.swift
//  iOSDesign
//
//  Created by sam on 16/3/6.
//  Copyright © 2016年 sam. All rights reserved.
//

import UIKit

//代理模式监听登录和注册点击事件
protocol VisitorLoginViewDelegate:NSObjectProtocol{
    //协议方法
    //登录方法
    func visitorWillLogin()
    
    //注册方法
    func visitorWillRegistor()
    
}

class VisitorLoginView: UIView {

    //声明代理属性,属性默认是强引用，需要添加weak
    weak var visitorDelegate:VisitorLoginViewDelegate?
    
    //登录 注册方法的实现
    @objc func loginDidBtnClick(){
        //代理调用协议的方法
        visitorDelegate?.visitorWillLogin()
    }
    
    @objc func registorBtnClick(){
        visitorDelegate?.visitorWillRegistor()
    }
    
    //MARK:设置页面信息
    func setUIInfo(imageName:String?,title:String){
        iconView.hidden=false
        tipLabel.text=title
        if imageName != nil{
            cycleView.image=UIImage(named:imageName!)
            iconView.hidden=true
            
        }else{
            //动画效果 让cycleview动起来
            startAnimation()
        }

    }
    
    private func startAnimation(){
        let anim=CABasicAnimation(keyPath: "transform.rotation")
        anim.repeatCount=MAXFLOAT
        anim.toValue=2*M_PI
        anim.duration=10
        anim.removedOnCompletion=false//当动画结束或者视图处于非活跃状态，动画不移除
        cycleView.layer.addAnimation(anim, forKey: nil)
    }
    
    
    //重写init方法
    init() {
        super.init(frame: CGRectZero)//初始化
        setupUI()//调用下面的方法
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK：设置访客视图
    private func setupUI(){
//        backgroundColor=UIColor.redColor()//做一个测试看看是不是成功了。
        addSubview(cycleView)
        addSubview(backView)
        addSubview(iconView)
        addSubview(tipLabel)//这两行把下面的控件都加进来了。
        addSubview(loginBtn)
        addSubview(registerBtn)

        //都进来之后，设置布局
        //先让本身的布局失效才会显示自己定义的效果
//        cycleView.translatesAutoresizingMaskIntoConstraints=false
//        iconView.translatesAutoresizingMaskIntoConstraints=false
        //把上面两行改成for循环
        for v in subviews{
            v.translatesAutoresizingMaskIntoConstraints=false
        }
        
        //使用VFL方式 自定义布局
        
        //回转动的圆圈的布局，
        //全靠公式"view1.attr1 = view2.attr2 * multiplier + constant" 的约束
        addConstraint(NSLayoutConstraint(item: cycleView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0))//设置了水平居中
        addConstraint(NSLayoutConstraint(item: cycleView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: -60))//设置了垂直居中
        
        //中间房子的布局，
        //注意约束要相对于 上面的一层。多层容易出错
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .CenterX, relatedBy: .Equal, toItem: cycleView, attribute: .CenterX, multiplier: 1.0, constant: 0))//设置了水平居中
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .CenterY, relatedBy: .Equal, toItem: cycleView, attribute: .CenterY, multiplier: 1.0, constant: 0))//设置了垂直居中
        
        //设置文案的约束
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .CenterX, relatedBy: .Equal, toItem: cycleView, attribute: .CenterX, multiplier: 1.0, constant: 0))//设置了水平居中
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .Top, relatedBy: .Equal, toItem: cycleView, attribute: .Bottom, multiplier: 1.0, constant: 16))//设置了垂直方向位置，16代表间隔。
        //如果文字过长，设置换行，设置宽度 修改点
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 236))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 35))
//        
        //设置 登录的样式
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Left, relatedBy: .Equal, toItem: tipLabel, attribute: .Left, multiplier: 1.0, constant: 0))//设置了水平居中
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Top, relatedBy: .Equal, toItem: tipLabel, attribute: .Bottom, multiplier: 1.0, constant: 16))//设置了垂直方向位置，16代表间隔。
        
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100))//宽度
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Height , relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 35))//高度
        
        //设置  注册的样式
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Right, relatedBy: .Equal, toItem: tipLabel, attribute: .Right, multiplier: 1.0, constant: 0))//设置了水平居中
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Top, relatedBy: .Equal, toItem: tipLabel, attribute: .Bottom, multiplier: 1.0, constant: 16))//设置了垂直方向位置，16代表间隔。
        
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100))//宽度
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Height , relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 35))//高度
        
        //设置渐隐的约束
        //位移枚举 || []
        //对视图高宽约束的数值[Sting:NSNumber]
        addConstraints( NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[backView]-0-|", options: [], metrics: nil, views: ["backView":backView]))
        addConstraints( NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[backView]-(-35)-[registerBtn]", options: [], metrics: nil, views: ["backView":backView,"registerBtn":registerBtn]))
        
        //设置背景颜色
        self.backgroundColor=UIColor(white: 0.93, alpha: 1)
        
        //添加点击事件
        loginBtn.addTarget(self, action: "loginDidBtnClick", forControlEvents: .TouchUpInside)
        registerBtn.addTarget(self, action: "registorBtnClick", forControlEvents: .TouchUpInside)
    }
    
    //MARK: 懒加载 所有的控件
    private lazy var cycleView:UIImageView=UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    private lazy var iconView:UIImageView=UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    private lazy var backView:UIImageView=UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))//渐隐的效果
    //提示文案
    private lazy var tipLabel:UILabel = {
        let l = UILabel()
        l.text="移动办公随时随地"
        l.font=UIFont.systemFontOfSize(26)
        l.textColor=UIColor.lightGrayColor()
        l.sizeToFit()//这个容易忘记，不写不显示
        l.numberOfLines=0//设置换行属性，这还不够，还要设置宽度
        return l
    }()//弄好了去上面setupUI添加一下
    
    //MARK:懒加载 登录 注册
    private lazy var loginBtn:UIButton={
        let btn=UIButton()//实例化一下
        btn.setTitle("登录", forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        return btn
    }()
    
    //流程，代码生成控件->代码设置控件的样式->添加到加载函数里
    private lazy var registerBtn:UIButton={
        let btn=UIButton()//实例化一下
        btn.setTitle("注册", forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        return btn
    }()
    
}
