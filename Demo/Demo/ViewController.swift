//
//  ViewController.swift
//  Demo
//
//  Created by MayerF on 2019/7/17.
//  Copyright © 2019 MayerF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let scrollView = UIScrollView()
    fileprivate let contentView = UIView()
    
    fileprivate let summaryLabel = UILabel()
    
    fileprivate let titleLabel1 = UILabel()
    fileprivate let textFieldView1 = LeftRightTextFieldView()
    
    fileprivate let titleLabel2 = UILabel()
    fileprivate let textFieldView2 = LeftRightTextFieldView()
    
    fileprivate let titleLabel3 = UILabel()
    fileprivate let textFieldView3 = LeftRightTextFieldView()
    
    fileprivate let titleLabel4 = UILabel()
    fileprivate let textFieldView4 = LeftRightTextFieldView()
    
    fileprivate let titleLabel5 = UILabel()
    fileprivate let textFieldView5 = LeftRightTextFieldView()
    
    fileprivate let titleLabel6 = UILabel()
    fileprivate let textFieldView6 = LeftRightTextFieldView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
        initConstraits()
    }

    fileprivate func initCommon() {
        
        summaryLabel.text = "所有控件都可定制边框颜色、hover颜色和光标颜色"
        summaryLabel.font = kFontRegular(13)
        summaryLabel.numberOfLines = 0
        
        // 1
        titleLabel1.text = "1. 左侧文本，右侧文本，中间输入框"
        titleLabel1.font = kFontRegular(13)
        textFieldView1.leftTitle = "金额"
        textFieldView1.rightTitle = "CNY"
        textFieldView1.placeHolder = "请输入金额"
        textFieldView1.borderCorner = 5
        textFieldView1.borderColor = UIColor(0xd1e1f2)
        textFieldView1.hoverColor = UIColor(0x23c0af)
        textFieldView1.cursorColor = UIColor(0x23c0af)
        
        // 2
        titleLabel2.text = "2. 左侧可变文本，右侧文本"
        titleLabel2.font = kFontRegular(13)
        let attM = NSMutableAttributedString(string: "姓名(仅支持英文)")
        let range = attM.string.range(of: "(仅支持英文)")
        if let _ = range {
            attM.addAttribute(NSAttributedString.Key.font, value: kFontMedium(15), range: NSRange(range!, in: attM.string))
            textFieldView2.leftAttriTitle = attM
        }
        textFieldView2.borderCorner = 5
        textFieldView2.rightTitle = "LeftRightTextFieldView"
        textFieldView2.textfield.isEnabled = false
        
        // 3
        titleLabel3.text = "3. 右侧文本，中间输入框"
        titleLabel3.font = kFontRegular(13)
        textFieldView3.rightTitle = "CNY"
        textFieldView3.placeHolder = "请输入最大金额"
        textFieldView3.borderCorner = 5
        textFieldView3.textfield.textAlignment = .left
        textFieldView3.borderColor = UIColor(0xd1e1f2)
        textFieldView3.hoverColor = UIColor(0x23c0af)
        textFieldView3.cursorColor = UIColor(0x23c0af)
        
        // 4
        titleLabel4.text = "4. 左侧文本，中间输入框,右侧可点击文本，且中间输入起始点距离左侧固定宽度"
        titleLabel4.font = kFontRegular(13)
        titleLabel4.numberOfLines = 0
        textFieldView4.leftTitle = "手机验证"
        textFieldView4.rightTitle = "获取验证码"
        textFieldView4.placeHolder = "请输入手机号码"
        textFieldView4.leftDistance = 80
        textFieldView4.borderCorner = 5
        textFieldView4.rightColor = UIColor(0x23c0af)
        textFieldView4.textfield.textAlignment = .left
        textFieldView4.borderColor = UIColor(0xd1e1f2)
        textFieldView4.hoverColor = UIColor(0x23c0af)
        textFieldView4.cursorColor = UIColor(0x23c0af)
        textFieldView4.bindRightAction { [unowned textFieldView4](result) in
            textFieldView4.rightTitle = "正在获取验证码"
        }
        
        // 5
        titleLabel5.text = "5. 仅有输入框"
        titleLabel5.font = kFontRegular(13)
        textFieldView5.placeHolder = "请输入验证码"
        textFieldView5.borderCorner = 5
        textFieldView5.textfield.textAlignment = .left
        textFieldView5.borderColor = UIColor(0xd1e1f2)
        textFieldView5.hoverColor = UIColor(0x23c0af)
        textFieldView5.cursorColor = UIColor(0x23c0af)
        
        // 6
        titleLabel6.text = "6. 左侧文本，右侧文本，中间输入框基础上调整两侧边距且去除边框圆角"
        titleLabel6.font = kFontRegular(13)
        textFieldView6.leftTitle = "金额"
        textFieldView6.rightTitle = "CNY"
        textFieldView6.placeHolder = "请输入金额"
        textFieldView6.inset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        textFieldView6.borderColor = UIColor(0xd1e1f2)
        textFieldView6.hoverColor = UIColor(0x23c0af)
        textFieldView6.cursorColor = UIColor(0x23c0af)
        
        // 7
//        titleLabel6.text = "6. 输入框过滤匹配-仅支持数字"
//        titleLabel6.font = kFontRegular(13)
//        textFieldView6.leftTitle = "金额"
//        textFieldView6.rightTitle = "CNY"
//        textFieldView6.placeHolder = "请输入金额"
//        textFieldView6.inset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
//        textFieldView6.borderColor = UIColor(0xd1e1f2)
//        textFieldView6.hoverColor = UIColor(0x23c0af)
//        textFieldView6.cursorColor = UIColor(0x23c0af)
        
    }
    
    fileprivate func initConstraits() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(summaryLabel)
        
        contentView.addSubview(titleLabel1)
        contentView.addSubview(textFieldView1)
        
        contentView.addSubview(titleLabel2)
        contentView.addSubview(textFieldView2)
        
        contentView.addSubview(titleLabel3)
        contentView.addSubview(textFieldView3)
        
        contentView.addSubview(titleLabel4)
        contentView.addSubview(textFieldView4)
        
        contentView.addSubview(titleLabel5)
        contentView.addSubview(textFieldView5)
        
        contentView.addSubview(titleLabel6)
        contentView.addSubview(textFieldView6)
        
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        summaryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(50)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        
        titleLabel1.snp.makeConstraints { (make) in
            make.top.equalTo(summaryLabel.snp.bottom).offset(20)
            make.left.right.equalTo(summaryLabel)
        }
        textFieldView1.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel1.snp.bottom).offset(10)
            make.left.right.equalTo(summaryLabel)
            make.height.equalTo(44)
        }
        
        titleLabel2.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldView1.snp.bottom).offset(20)
            make.left.right.equalTo(summaryLabel)
        }
        textFieldView2.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel2.snp.bottom).offset(10)
            make.left.right.equalTo(summaryLabel)
            make.height.equalTo(44)
        }
        
        titleLabel3.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldView2.snp.bottom).offset(20)
            make.left.right.equalTo(summaryLabel)
        }
        textFieldView3.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel3.snp.bottom).offset(10)
            make.left.right.equalTo(summaryLabel)
            make.height.equalTo(44)
        }
        
        titleLabel4.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldView3.snp.bottom).offset(20)
            make.left.right.equalTo(summaryLabel)
        }
        textFieldView4.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel4.snp.bottom).offset(10)
            make.left.right.equalTo(summaryLabel)
            make.height.equalTo(44)
        }
        
        titleLabel5.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldView4.snp.bottom).offset(20)
            make.left.right.equalTo(summaryLabel)
        }
        textFieldView5.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel5.snp.bottom).offset(10)
            make.left.right.equalTo(summaryLabel)
            make.height.equalTo(44)
        }
        
        titleLabel6.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldView5.snp.bottom).offset(20)
            make.left.right.equalTo(summaryLabel)
        }
        textFieldView6.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel6.snp.bottom).offset(10)
            make.left.right.equalTo(summaryLabel)
            make.height.equalTo(44)
        }
    }

}

