//
//  UIColor+Helper.swift
//  Demo
//
//  Created by MayerF on 2019/7/17.
//  Copyright © 2019 MayerF. All rights reserved.
//

import UIKit

public let kFontMedium:(CGFloat) -> UIFont = { size in
    return UIFont(name: "PingFangSC-Medium", size: size)!
}

public let kFontRegular:(CGFloat) -> UIFont = { size in
    return UIFont(name: "PingFangSC-Regular", size: size)!
}

extension UIColor {
    
    /// 便利构造器
    ///
    /// - Parameter hex: 十六进制
    convenience init(_ hex: Int) {
        self.init(hex, 1)
    }
    
    /// 便利构造器
    ///
    /// - Parameters:
    ///   - hex: 十六进制
    ///   - alpha: 透明度
    convenience init(_ hex: Int, _ alpha: CGFloat) {
        self.init(red: CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255),
                  green: CGFloat(CGFloat((hex & 0xFF00) >> 8)/255),
                  blue: CGFloat(CGFloat(hex & 0xFF)/255),
                  alpha: alpha)
    }
}

//MARK: - 计算字符串size
extension String {
    func boundingSize(size: CGSize, font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        return (self as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
    }
}
