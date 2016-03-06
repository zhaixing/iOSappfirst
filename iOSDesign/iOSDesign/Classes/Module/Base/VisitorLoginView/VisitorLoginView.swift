//
//  VisitorLoginView.swift
//  iOSDesign
//
//  Created by sam on 16/3/6.
//  Copyright © 2016年 sam. All rights reserved.
//

import UIKit

class VisitorLoginView: UIView {

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
        //如果文字过长，设置换行，设置宽度
//        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 224))
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
    }
    
    //MARK: 懒加载 所有的控件
    private lazy var cycleView:UIImageView=UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    private lazy var iconView:UIImageView=UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
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
