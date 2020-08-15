//
//  NSString+Match.h
//  Demo_OC
//
//  Created by MayerF on 2020/8/13.
//  Copyright © 2020 MayerF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Match)

//************************* 输入结束后校验 ***************************//

/// 匹配手机号（输入完成之后的校验）
- (BOOL)my_verifyPhoneNumber;

/// 匹配数字或带小数点的数字（输入完成之后的校验）
///
/// 首位不能是0， 如果有小数，且小数位数至少为1位
/// @param point 小数点保留位数 至少1位
- (BOOL)my_verifyDecimalNumber:(NSUInteger)point;


//************************* 输入过程校验 ***************************//

/// 匹配数字或带小数点的数字（输入过程中的过滤）
///
/// 首位不能是0， 如果有小数，且小数位数至少为1位
/// - Parameter point: 小数点保留位数
/// - Returns: 是否匹配成功
- (BOOL)my_filterDecimalNumber:(NSUInteger)point;


//************************* 两者皆可 ***************************//

/// 仅仅匹配数字[0-9]（用于输入完成的校验 + 输入过程中的过滤）
///
/// - Returns: 是否匹配成功
- (BOOL)my_isNumber;

/// 仅仅匹配正整数（用于输入完成的校验 + 输入过程中的过滤）
///
/// - Returns: 是否匹配成功
- (BOOL)my_isPositiveNumber;

/// 匹配自定义正则
/// @param regex 正则字符串
- (BOOL)my_matchCustomRegex:(NSString *)regex;

@end

NS_ASSUME_NONNULL_END
