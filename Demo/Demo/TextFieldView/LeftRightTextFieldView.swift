//
//  LeftRightTextFieldView.swift
//  58Spot
//
//  Created by MayerF on 2019/4/9.
//  Copyright © 2019 AFRO. All rights reserved.
//
//  https://github.com/MayerFan/LeftRightTextFieldView

/**
 *
 *  ┌┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┐
 *   | left文本                                 中间输入框                                       right文本|
 *  └┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┘
 *  左右侧文本可选择显示
 *  右侧文案可点击
 *  可以演变多种布局样式
 *  一、可定制边框颜色、hover颜色和光标颜色
 *  二、可以统一指定输入过程的过滤规则，如果需要更细度的过滤规则，则需要在代理回调方法中自定义处理
 *  三、没有边框仅有下划线的UI样式
 */

import UIKit
import SnapKit

enum kInputFilterType {
    /// 纯数字
    case numer
    /// 正整数
    case positveNumer
    /// 带小数的数字, 参数为保留的小数位数
    case decimalNumer(Int)
    /// 外部自定义的正则
    case customType(String)
}

//MARK: - CustomTextField
//MARK: ///

class CustomTextField: UITextField {
    var padding: CGFloat = 5
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.size.width -= padding*2
        return rect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.size.width -= padding*2
        return rect
    }
}



//MARK: - CustomTextField
//MARK: ///

@objcMembers
class LeftRightTextFieldView: UIView {
    
    fileprivate lazy var leftLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        label.textColor = UIColor(0x242c4d)
        label.font = kFontRegular(15)
        return label
    }()
    fileprivate lazy var rightLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        label.textColor = UIColor(0x677197)
        label.font = kFontMedium(14)
        label.textAlignment = .right
        return label
    }()
    /// 下划线
    fileprivate lazy var underline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(0xeff2f6)
        addSubview(view)
        return view
    }()
    /// 右侧闭包
    fileprivate var rightClickBlock: ((Any?) -> Void)?
    
    /// 用于处理输入过滤的临时文本
    fileprivate var tempText: String = ""
    
    /// 左侧文本宽度
    var leftWidth: CGFloat {
        get {
            let maxW = textfield.frame.width
            let maxH = textfield.frame.height
            let w = leftTitle!.boundingSize(size: CGSize(width: maxW, height: maxH), font: rightFont).width
            return w + textPadding + inset.left
        }
    }
    
    let textfield = CustomTextField()
    
    /// textfeild距离左侧的固定距离. 默认是距离左侧文本5间距
    var leftDistance: CGFloat?
    
    /// 输入内容距离 leftview 和 rightview 的间距
    var textPadding: CGFloat = 5 {
        didSet {
            textfield.padding = textPadding
        }
    }
    
    var inputFilterType: kInputFilterType?
    
    /// 是否显示下划线 默认不显示
    var showUnderline = false
    
    var underlineColor: UIColor? {
        didSet {
            underline.backgroundColor = underlineColor
        }
    }
    
    /// 下划线hover颜色
    var underlineHoverColor: UIColor?
    
    /// 下划线高度
    var underlineHeight = 0.5
    
    /// 下划线页边距 （top，bottom 设置无效）
    var underlineInset = UIEdgeInsets()
    
    /// 页边距 默认为（0， 10， 0， 10）
    var inset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) {
        didSet {
            textfield.snp.updateConstraints { (make) in
                make.edges.equalTo(self).inset(inset)
            }
        }
    }
    
    /// 左侧文本
    var leftTitle: String? {
        didSet {
            if let title = leftTitle {
                if leftLabel.text != title {
                    leftLabel.text = title
                    textfield.leftView = leftLabel
                    setNeedsLayout()
                }
            }
        }
    }
    /// 左侧attribute文本
    var leftAttriTitle: NSAttributedString? {
        didSet {
            if let title = leftAttriTitle {
                leftTitle = title.string
                leftLabel.attributedText = title
                setNeedsLayout()
            }
        }
    }
    /// 右侧文本
    var rightTitle: String? {
        didSet {
            if let title = rightTitle {
                if rightLabel.text != title {
                    rightLabel.text = title
                    textfield.rightView = rightLabel
                    setNeedsLayout()
                }
            }
        }
    }
    /// textfield 占位文案
    var placeHolder: String? {
        didSet {
            if let holder = placeHolder {
                let attStr = NSMutableAttributedString(string: holder)
                attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(0xa2a8c3), range: NSRange(location: 0, length: holder.count))
                attStr.addAttribute(NSAttributedString.Key.font, value: kFontRegular(14), range: NSRange(location: 0, length: holder.count))
                textfield.attributedPlaceholder = attStr
            }
        }
    }
    
    /// 边框宽度
    var borderWidth: CGFloat? {
        didSet {
            if let width = borderWidth {
                layer.borderWidth = width
            }
        }
    }
    /// 边框颜色
    var borderColor: UIColor? {
        didSet {
            if let color = borderColor {
                if borderWidth == nil {
                    borderWidth = 0.5
                }
                layer.borderColor = color.cgColor
            }
        }
    }
    /// 圆角
    var borderCorner: CGFloat? {
        didSet {
            if let corner = borderCorner {
                layer.cornerRadius = corner
            }
        }
    }
    /// 光标颜色
    var cursorColor: UIColor? {
        didSet {
            if let color = cursorColor {
                textfield.tintColor = color
            }
        }
    }
    /// hover颜色
    var hoverColor: UIColor? {
        didSet {
            if borderWidth == nil {
                borderWidth = 0.5
            }
        }
    }
    
    /// 左侧字体
    var leftFont = kFontRegular(15) {
        didSet {
            leftLabel.font = leftFont
        }
    }
    /// 右侧字体
    var rightFont = kFontMedium(14) {
        didSet {
            rightLabel.font = rightFont
        }
    }
    
    /// 左侧文本颜色
    var leftColor: UIColor? {
        didSet {
            if let _ = leftColor {
                leftLabel.textColor = leftColor!
            }
        }
    }
    /// 右侧文本颜色
    var rightColor: UIColor? {
        didSet {
            if let _ = rightColor {
                rightLabel.textColor = rightColor!
            }
        }
    }
    
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
        initConstraints()
    }
    fileprivate func initCommon() {
        backgroundColor = UIColor(0xf8f9fd)
        
        textfield.textColor = UIColor(0x242c4d)
        textfield.font = kFontMedium(16)
        textfield.textAlignment = .right
        textfield.leftViewMode = .always
        textfield.rightViewMode = .always
        
        NotificationCenter.default.addObserver(self, selector: #selector(textfeildBeginEdit), name: UITextField.textDidBeginEditingNotification, object: textfield)
        NotificationCenter.default.addObserver(self, selector: #selector(textfeildEndEdit), name: UITextField.textDidEndEditingNotification, object: textfield)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: textfield)
    }
    func initConstraints() {
        addSubview(textfield)
        textfield.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(inset)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - 布局 逻辑
extension LeftRightTextFieldView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let maxW = textfield.frame.width
        let maxH = textfield.frame.height
        if maxW == 0 && maxH == 0 { return }
        
        if #available(iOS 13, *) {}
        else {
            if let title = leftTitle {
                let w = title.boundingSize(size: CGSize(width: maxW, height: maxH), font: leftFont).width

                var leftW = w + 5;
                if let _ = leftDistance {
                    leftW = leftDistance! < leftW ? leftW : leftDistance!;
                }
                var x = CGFloat(0)
                if let _ = textfield.leftView {
                    x = textfield.leftView!.frame.minX
                }
                leftLabel.frame = CGRect(x: x, y: 0, width: leftW, height: maxH)
            }

            if let title = rightTitle {
                let w = title.boundingSize(size: CGSize(width: maxW, height: maxH), font: rightFont).width
                var x = CGFloat(0)
                if let _ = textfield.rightView {
                    x = textfield.rightView!.frame.minX
                }
                rightLabel.frame = CGRect(x: x, y: 0, width: w + 5, height: maxH)
            }
        }
        
        // 处理下划线
        if showUnderline {
            let X = 0 + underlineInset.left
            let Y = maxH - CGFloat(underlineHeight);
            let W = frame.width - underlineInset.left - underlineInset.right
            underline.frame = CGRect(x: X, y: Y, width: W, height: CGFloat(underlineHeight))
        }
    }
}

//MARK: - action
extension LeftRightTextFieldView {
    
    @objc func textfeildBeginEdit() {
        if let color = hoverColor {
            layer.borderColor = color.cgColor
        }
        
        if let color = underlineHoverColor {
            underline.backgroundColor = color
        }
    }
    
    @objc func textfeildEndEdit() {
        if let color = borderColor {
            layer.borderColor = color.cgColor
        }
        
        if showUnderline {
            var color = UIColor(0xeff2f6)
            if let _ = underlineColor {
                color = underlineColor!
            }
            underline.backgroundColor = color
        }
    }
    
    @objc func textDidChange() {
        print("===\(tempText) ===\(textfield.text!)")
        guard let _ = inputFilterType else { return}
        
        let text = textfield.text!
        
        switch inputFilterType! {
        case .numer:
            if text != "" && !text.isNumber() {
                textfield.text = tempText
            }
        case .positveNumer:
            if text != "" && !text.isPositiveNumber() {
                textfield.text = tempText
            }
        case .decimalNumer(let point):
            if text != "" && !text.filterDecimalNumber(point: point) {
                textfield.text = tempText
            }
        case .customType(let regex):
            if text != "" && !text.isMatchCustom(regex: regex) {
                textfield.text = tempText
            }
        }
        
        tempText = textfield.text!
    }
    
    @objc func tapClick() {
        if let _ = rightClickBlock {
            rightClickBlock!(rightTitle)
        }
    }
}

//MARK: - public API
extension LeftRightTextFieldView {
    
    /// 右侧添加点击响应
    ///
    /// - Parameter action: 回调闭包
    @objc func bindRightAction(_ action: @escaping (Any?) -> Void) {
        rightClickBlock = action
        rightLabel.isUserInteractionEnabled = true
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        rightLabel.addGestureRecognizer(tapGuesture)
    }
    
    /// 仅供OC使用的 添加输入过滤类型。SWIFT 版请使用更直观的枚举属性
    /// - Parameters:
    ///   - type: 0： 自定义类型；1：纯数字类型；2：正整数类型；3：带小数的数字
    ///   - content: 成对出现。对于type==0，content 为外部自定义的正则；对于type==3，content 为要保留的小数位数
    @objc func addFilterType(_ type: Int, content: AnyObject?) -> Void {
        switch type {
        case 0:
            assert(content != nil, "自定义类型需要传入正则")
            assert(content! is String, "请输入字符串类型的正则")
            inputFilterType = .customType(content! as! String)
        case 1:
            inputFilterType = .numer
        case 2:
            inputFilterType = .positveNumer
        case 3:
            assert(content != nil, "请传入需要保留的小数位数")
            let number = content! as! NSNumber
            inputFilterType = .decimalNumer(number.intValue)
        default:
            print("")
        }
    }
}
