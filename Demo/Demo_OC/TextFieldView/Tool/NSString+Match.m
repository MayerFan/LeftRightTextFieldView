//
//  NSString+Match.m
//  Demo_OC
//
//  Created by MayerF on 2020/8/13.
//  Copyright © 2020 MayerF. All rights reserved.
//
//  https://github.com/MayerFan/LeftRightTextFieldView

//  1. 输入过程中的过滤都可以用于输入完成后的校验，但是可能条件稍微宽松
//  2. 输入完成后的校验匹配严格
//  3. 用于校验的都以<verify>开头， 用于过滤的都以<filter>开头， 除此之外是两者都可用的（一般以<is>或<match>）开头

#import "NSString+Match.h"

@implementation NSString (Match)

//************************* 输入结束后校验 ***************************//

/// 匹配手机号（输入完成之后的校验）
- (BOOL)my_verifyPhoneNumber {
    NSString *regex = @"^[1][3-8]\\d{9}$";
    
    return [self my_matchCustomRegex:regex];
}

/// 匹配数字或带小数点的数字（输入完成之后的校验）
///
/// 首位不能是0， 如果有小数，且小数位数至少为1位
/// @param point 小数点保留位数 至少1位
- (BOOL)my_verifyDecimalNumber:(NSUInteger)point {
    NSUInteger pointNum = 1;
    pointNum = point > 1 ? point : pointNum;
    
    NSString *regex = [NSString stringWithFormat:@"^([1-9]\\d*)|([1-9]\\d*\\.{1}\\d{1,%lu})$", (unsigned long)pointNum];
    
    return [self my_matchCustomRegex:regex];
}


//************************* 输入过程校验 ***************************//

/// 匹配数字或带小数点的数字（输入过程中的过滤）
///
/// 首位不能是0， 如果有小数，且小数位数至少为1位
/// - Parameter point: 小数点保留位数
/// - Returns: 是否匹配成功
- (BOOL)my_filterDecimalNumber:(NSUInteger)point {
    NSUInteger pointNum = 1;
    pointNum = point > 1 ? point : pointNum;
    
    NSString *regex = [NSString stringWithFormat:@"^(\\d+\\.{0,1})|(\\d+\\.{1}\\d{0,%lu})$", (unsigned long)pointNum];
    
    return [self my_matchCustomRegex:regex];
}


//************************* 两者皆可 ***************************//

/// 仅仅匹配数字[0-9]（用于输入完成的校验 + 输入过程中的过滤）
///
/// - Returns: 是否匹配成功
- (BOOL)my_isNumber {
    NSString *regex = @"\\d+";
    
    return [self my_matchCustomRegex:regex];
}

/// 仅仅匹配正整数（用于输入完成的校验 + 输入过程中的过滤）
///
/// - Returns: 是否匹配成功
- (BOOL)my_isPositiveNumber {
    NSString *regex = @"^[1-9]\\d*$";
    
    return [self my_matchCustomRegex:regex];
}

/// 匹配自定义正则
/// @param regex 正则字符串
- (BOOL)my_matchCustomRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicate evaluateWithObject:self];
}

@end
