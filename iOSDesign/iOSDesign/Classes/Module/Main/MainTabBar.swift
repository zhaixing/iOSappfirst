//
//  MainTabBar.swift
//  iOSDesign
//
//  Created by sam on 16/3/6.
//  Copyright © 2016年 sam. All rights reserved.
//

import UIKit

class MainTabBar: UITabBar {

    //默认的构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()//不管通过哪种方式都不会报错
    }
    
    //如果重写的init（frame）系统会默认这个控件是通过代码创建
    required init?(coder aDecoder: NSCoder) {
        //默认报错的语句，如果调用者通过sb/xib创建了该对象，系统就崩溃
        //fatalError("init(coder:) has not been implemented")
        super.init(coder:aDecoder)
        
        setupUI()//不管通过哪种方式都不会报错
    }
    
    //把下面修改的按钮添加一下
    private func setupUI(){
        //添加撰写button
        addSubview(composeBtn)
    }
    
    //把中间的位置空出来
    override func layoutSubviews() {
        super.layoutSubviews()
        //手动修改所有的按钮位置
        //print(subviews)//打印那些控件
        
        //怎么找到想要的那个控件
        //遍历所有的控件显示
        let w = self.bounds.width/5
        let h = self.bounds.height
        let rect = CGRect(x: 0, y: 0, width: w, height: h)//获取了位置，面积size
        
        //定义递增变量
        var index : CGFloat = 0  //下面乘法的时候遇到了类型不匹配的问题。定义类型CGFloat
        for subview in subviews{
            //print(subview)
            if subview.isKindOfClass(NSClassFromString("UITabBarButton")!){
//                print(subview)
                //修改frame，去上面先定义一下
                subview.frame=CGRectOffset(rect, index * w, 0) //w要递增去上面定义一个递增的变量
                //上面的代码会把四个button一块向左移动，需要空出中间的位置
//                if index == 1{
//                    index++
//                }
//                index++
                
                //上面这个四行代码可以 优化 ，用 “三目运算符”
                index += index == 1 ? 2 :1
            }
            
        }
        //设置撰写按钮的位置
        composeBtn.frame = CGRectOffset(rect, w * 2, 0)
        
        //中间的按钮凸起的代码
//        composeBtn.frame = CGRectOffset(rect, w * 2, -20)
//        bringSubviewToFront(        composeBtn)
        
    }
    
    //MARK 来加载撰写按钮
    lazy var composeBtn:UIButton = {
        //UIButton()这个方法会创建一个自定义的button
        let btn = UIButton()
        
        //设置按钮
        btn.setBackgroundImage( UIImage(named: "tabbar_compose_button")  , forState: UIControlState.Normal)
        
        btn.setBackgroundImage( UIImage(named: "tabbar_compose_button_highlighted")  , forState: UIControlState.Highlighted)
        
        btn.setImage( UIImage(named: "tabbar_compose_icon_add")  , forState: UIControlState.Normal)
        
        btn.setImage( UIImage(named: "tabbar_compose_icon_add_highlighted")  , forState: UIControlState.Highlighted)
        
        btn.sizeToFit()//让图片与背景图片大小相适应
        
        return btn
    }()
    

}
