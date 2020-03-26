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
    
    fileprivate let close = UIButton()
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
    
    fileprivate let titleLabel7 = UILabel()
    fileprivate let textFieldView7 = LeftRightTextFieldView()
    
    fileprivate let titleLabel8 = UILabel()
    fileprivate let textFieldView8 = LeftRightTextFieldView()
    
    fileprivate let titleLabel9 = UILabel()
    fileprivate let textFieldView9 = LeftRightTextFieldView()
    
    fileprivate let titleLabel10 = UILabel()
    fileprivate let textFieldView10 = LeftRightTextFieldView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
        initConstraits()
    }

    fileprivate func initCommon() {
        
        close.setTitle("关闭键盘", for: .normal)
        close.setTitleColor(UIColor.black, for: .normal)
        close.addTarget(self, action: #selector(closeOnClick), for: .touchUpInside)
        
        summaryLabel.text = "一、可定制边框颜色、hover颜色和光标颜色\n二、可以统一指定输入过程的过滤规则，如果需要更细度的过滤规则，则需要在代理回调方法中自定义处理\n三、没有边框仅有下划线的UI样式"
        summaryLabel.font = kFontRegular(13)
        summaryLabel.textColor = UIColor(0x23c0af)
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
        textFieldView4.leftDistance = 90
        textFieldView4.borderCorner = 5
        textFieldView4.rightColor = UIColor(0x23c0af)
        textFieldView4.textfield.textAlignment = .left
        textFieldView4.borderColor = UIColor(0xd1e1f2)
        textFieldView4.hoverColor = UIColor(0x23c0af)
        textFieldView4.cursorColor = UIColor(0x23c0af)
        textFieldView4.bindRightAction { [unowned textFieldView4](result) in
            textFieldView4.rightTitle = "正在获取验证码..."
        }
        
        // 5
        titleLabel5.text = "5. 仅有输入框"
        titleLabel5.font = kFontRegular(13)
        textFieldView5.placeHolder = "请输入验证码"
        textFieldView5.borderCorner = 5
        textFieldView5.textfield.textAlignment = .center
        textFieldView5.borderColor = UIColor(0xd1e1f2)
        textFieldView5.hoverColor = UIColor(0x23c0af)
        textFieldView5.cursorColor = UIColor(0x23c0af)
        
        // 6
        titleLabel6.text = "6. 左侧文本，右侧文本，中间输入框基础上调整两侧边距且去除边框圆角"
        titleLabel6.font = kFontRegular(13)
        titleLabel6.numberOfLines = 0
        textFieldView6.leftTitle = "金额"
        textFieldView6.rightTitle = "CNY"
        textFieldView6.placeHolder = "请输入金额"
        textFieldView6.inset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        textFieldView6.borderColor = UIColor(0xd1e1f2)
        textFieldView6.hoverColor = UIColor(0x23c0af)
        textFieldView6.cursorColor = UIColor(0x23c0af)
        
        // 7
        titleLabel7.text = "7. 输入框过滤非纯数字"
        titleLabel7.font = kFontRegular(13)
        textFieldView7.leftTitle = "金额"
        textFieldView7.rightTitle = "CNY"
        textFieldView7.placeHolder = "非[0-9]皆不可输入"
        textFieldView7.inputFilterType = .numer
        textFieldView7.borderColor = UIColor(0xd1e1f2)
        textFieldView7.hoverColor = UIColor(0x23c0af)
        textFieldView7.cursorColor = UIColor(0x23c0af)
        
        // 8
        titleLabel8.text = "8. 输入框过滤非正整数"
        titleLabel8.font = kFontRegular(13)
        textFieldView8.leftTitle = "金额"
        textFieldView8.rightTitle = "CNY"
        textFieldView8.placeHolder = "只能输入非正整数"
        textFieldView8.inputFilterType = .positveNumer
        textFieldView8.borderColor = UIColor(0xd1e1f2)
        textFieldView8.hoverColor = UIColor(0x23c0af)
        textFieldView8.cursorColor = UIColor(0x23c0af)
        
        // 9
        titleLabel9.text = "9. 输入框过滤 仅支持数字或小数，且保留2小数位数"
        titleLabel9.font = kFontRegular(13)
        textFieldView9.leftTitle = "金额"
        textFieldView9.rightTitle = "CNY"
        textFieldView9.placeHolder = "仅支持数字或小数，且保留2小数位数"
        textFieldView9.inputFilterType = .decimalNumer(2)
        textFieldView9.borderColor = UIColor(0xd1e1f2)
        textFieldView9.hoverColor = UIColor(0x23c0af)
        textFieldView9.cursorColor = UIColor(0x23c0af)
        
        // 10
        titleLabel10.text = "10. 没有边框且底部仅有下划线，下划线自由扩展"
        titleLabel10.font = kFontRegular(13)
        textFieldView10.backgroundColor = .clear
        textFieldView10.showUnderline = true
        textFieldView10.underlineHeight = 5
        textFieldView10.underlineInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -10)
        textFieldView10.underlineHoverColor = UIColor(0x23c0af)
        textFieldView10.rightTitle = "获取验证码"
        textFieldView10.placeHolder = "请输入验证码"
        textFieldView10.textfield.textAlignment = .left
        textFieldView10.rightColor = UIColor(0x23c0af)
        textFieldView10.bindRightAction { [unowned textFieldView10](result) in
            textFieldView10.rightTitle = "正在获取验证码..."
        }
        
    }
    
    fileprivate func initConstraits() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(close)
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
        
        contentView.addSubview(titleLabel7)
        contentView.addSubview(textFieldView7)
        
        contentView.addSubview(titleLabel8)
        contentView.addSubview(textFieldView8)
        
        contentView.addSubview(titleLabel9)
        contentView.addSubview(textFieldView9)
        
        contentView.addSubview(titleLabel10)
        contentView.addSubview(textFieldView10)
        
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(textFieldView10).offset(250)
        }
        
        close.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(60)
        }
        summaryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(close.snp.bottom)
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
        
        titleLabel7.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldView6.snp.bottom).offset(20)
            make.left.right.equalTo(summaryLabel)
        }
        textFieldView7.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel7.snp.bottom).offset(10)
            make.left.right.equalTo(summaryLabel)
            make.height.equalTo(44)
        }
        
        titleLabel8.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldView7.snp.bottom).offset(20)
            make.left.right.equalTo(summaryLabel)
        }
        textFieldView8.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel8.snp.bottom).offset(10)
            make.left.right.equalTo(summaryLabel)
            make.height.equalTo(44)
        }
        
        titleLabel9.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldView8.snp.bottom).offset(20)
            make.left.right.equalTo(summaryLabel)
        }
        textFieldView9.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel9.snp.bottom).offset(10)
            make.left.right.equalTo(summaryLabel)
            make.height.equalTo(44)
        }
        
        titleLabel10.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldView9.snp.bottom).offset(20)
            make.left.right.equalTo(summaryLabel)
        }
        textFieldView10.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel10.snp.bottom).offset(10)
            make.left.right.equalTo(summaryLabel)
            make.height.equalTo(44)
        }
    
    }

}


extension ViewController {
    
    @objc func closeOnClick() {
        view.endEditing(true)
    }
}

