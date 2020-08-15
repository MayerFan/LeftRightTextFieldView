//
//  String+Match.swift
//  Demo
//
//  Created by MayerF on 2019/7/17.
//  Copyright © 2019 MayerF. All rights reserved.
//
//  https://github.com/MayerFan/LeftRightTextFieldView

//  1. 输入过程中的过滤都可以用于输入完成后的校验，但是可能条件稍微宽松
//  2. 输入完成后的校验匹配严格
//  3. 用于校验的都以<verify>开头， 用于过滤的都以<filter>开头， 除此之外是两者都可用的（一般以<is>或<match>）开头

import Foundation

//MARK: - 输入完成后的校验
extension String {
    
    /// 匹配手机号（输入完成之后的校验）
    ///
    /// - Returns: 是否匹配成功
    func verifyPhoneNumber() -> Bool {
        // 第一种方式
//        let regex = "\"^[1][3-8]\\d{9}$\""
//        let predicate = NSPredicate.init(format: "SELF MATCHES \(regex)")
        // 第二种方式
        let regex = "^[1][3-8]\\d{9}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with:self)
    }
    
    /// 匹配数字或带小数点的数字（输入完成之后的校验）
    ///
    /// 首位不能是0， 如果有小数，且小数位数至少为1位
    /// - Parameter point: 小数点保留位数 默认2位
    /// - Returns: 是否匹配成功
    func verifyDecimalNumber(point: Int = 2) -> Bool {
        var tempPoint = point
        tempPoint = tempPoint < 1 ? 1: tempPoint
        let regex = "^([1-9]\\d*)|([1-9]\\d*\\.{1}\\d{1,\(tempPoint)})$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with:self)
    }
}


//MARK: - 输入过程中的过滤
extension String {
    
    /// 匹配数字或带小数点的数字（输入过程中的过滤）
    ///
    /// - Parameter point: 小数点保留位数 默认2位
    /// - Returns: 是否匹配成功
    func filterDecimalNumber(point: Int = 2) -> Bool {
        let regex = "^(\\d+\\.{0,1})|(\\d+\\.{1}\\d{0,\(point)})$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with:self)
    }
}


//MARK: - 两者皆可
extension String {
    
    /// 仅仅匹配数字[0-9]（用于输入完成的校验 + 输入过程中的过滤）
    ///
    /// - Returns: 是否匹配成功
    func isNumber() -> Bool {
        let regex = "\\d+"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with:self)
    }
    
    /// 仅仅匹配正整数（用于输入完成的校验 + 输入过程中的过滤）
    ///
    /// - Returns: 是否匹配成功
    func isPositiveNumber() -> Bool {
        let regex = "^[1-9]\\d*$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with:self)
    }
    
    func isMatchCustom(regex: String) -> Bool {
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with:self)
    }
}
