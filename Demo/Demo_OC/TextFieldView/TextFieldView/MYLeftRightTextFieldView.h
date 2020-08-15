//
//  MYLeftRightTextFieldView.h
//  Demo_OC
//
//  Created by MayerF on 2019/8/13.
//  Copyright © 2019 MayerF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTextField : UITextField
/// 输入内容距离 leftview 和 rightview 的距离。默认 5
@property (nonatomic, assign) CGFloat padding;
@end


/// 输入过滤内容类型
typedef NS_ENUM(NSInteger, kInputFilterType) {
    kInputFilterType_none,
    /// 纯数字
    kInputFilterType_number,
    /// 正整数
    kInputFilterType_positveNumber,
    /// 带小数的数字, 参数为保留的小数位数
    kInputFilterType_decimalNumber,
    /// 外部自定义的过滤正则
    kInputFilterType_custom
};

NS_ASSUME_NONNULL_BEGIN

@interface MYLeftRightTextFieldView : UIView

@property (nonatomic, strong, readonly) MYTextField *textField;

/// 输入内容距离 leftview 和 rightview 的间距。默认为 5
@property (nonatomic, assign) CGFloat textPadding;

/// 指定textfeild距离左侧的固定距离。默认为 -1，小于0的情况不指定
@property (nonatomic, assign) CGFloat leftDistance;

/// 页边距 默认为（0， 10， 0， 10）
@property (nonatomic, assign) UIEdgeInsets inset;


//****************** 左侧文本相关 ******************//
/// 左侧文本
@property (nonatomic, strong) NSString *leftTitle;

/// 左侧字体
@property (nonatomic, strong) UIFont *leftFont;

/// 左侧文本颜色
@property (nonatomic, strong) UIColor *leftColor;

/// 左侧attribute文本
@property (nonatomic, strong) NSAttributedString *leftAttriTitle;


//****************** 右侧文本相关 ******************//
/// 右侧文本
@property (nonatomic, strong) NSString *rightTitle;

/// 右侧字体
@property (nonatomic, strong) UIFont *rightFont;

/// 右侧文本颜色
@property (nonatomic, strong) UIColor *rightColor;

//****************** 占位相关 ******************//
/// textfield 占位文案
@property (nonatomic, strong) NSString *placeHolder;

/// 占位字体
@property (nonatomic, strong) UIFont *placeHolderFont;

/// 占位文本颜色
@property (nonatomic, strong) UIColor *placeHolderColor;


//****************** 边框相关 ******************//
/// 边框宽度。 默认为 0.5
@property (nonatomic, assign) CGFloat borderWidth;

/// 边框颜色
@property (nonatomic, strong) UIColor *borderColor;

/// 圆角
@property (nonatomic, assign) CGFloat borderCorner;

/// hover颜色
@property (nonatomic, strong) UIColor *hoverColor;

/// 光标颜色
@property (nonatomic, strong) UIColor *cursorColor;


//****************** 下划线相关 ******************//
/// 是否显示下划线 默认不显示
@property (nonatomic, assign) BOOL showUnderline;

@property (nonatomic, strong) UIColor *underlineColor;

/// 下划线hover颜色
@property (nonatomic, strong) UIColor *underlineHoverColor;

/// 下划线高度。 默认为 0.5
@property (nonatomic, assign) CGFloat underlineHeight;

/// 下划线页边距 （top，bottom 设置无效）
@property (nonatomic, assign) UIEdgeInsets underlineInset;


/// 输入过滤内容类型
@property (nonatomic, assign, readonly) kInputFilterType inputFilterType;

/// 添加输入过滤类型
/// @param type 输入过滤类型
/// @param content 成对出现。对于kInputFilterType_custom，content 为外部自定义的正则【String】；
/// 对于kInputFilterType_decimalNumber，content 为要保留的小数位数【String | NSNumber】
- (void)addFilterType:(kInputFilterType)type content:(nullable id)content;

- (void)bindRightAction:(void(^)(id))action;

@end

NS_ASSUME_NONNULL_END
