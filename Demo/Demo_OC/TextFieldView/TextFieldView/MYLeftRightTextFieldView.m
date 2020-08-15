//
//  MYLeftRightTextFieldView.m
//  Demo_OC
//
//  Created by MayerF on 2019/8/13.
//  Copyright © 2019 MayerF. All rights reserved.
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

#import "MYLeftRightTextFieldView.h"
#import "Macros.h"
#import "NSString+Match.h"
#import "NSString+TextSize.h"
#import <Masonry/Masonry.h>

@interface MYLeftRightTextFieldView ()
@property (nonatomic, strong) MYTextField *textField;
@property (nonatomic, strong) UILabel *leftLabel;       //左侧内容
@property (nonatomic, strong) UILabel *rightLabel;      //右侧内容
@property (nonatomic, strong) UIView *underLine;        //下划线

@property (nonatomic, copy)   void(^rightClickBlock)(id);

/// 输入过滤内容类型
@property (nonatomic, assign, readwrite) kInputFilterType inputFilterType;
@property (nonatomic, strong) NSString *regex;
/// 保留小数位数。默认 2位
@property (nonatomic, assign) NSUInteger digist;

/// 用于处理输入过滤的临时文本
@property (nonatomic, strong) NSString *tempText;
@end

@implementation MYLeftRightTextFieldView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initCommon];
        [self initConstraints];
    }
    return self;
}

- (void)initCommon {
    self.backgroundColor = kColor(0xf8f9fd);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfeildBeginEdit) name:UITextFieldTextDidBeginEditingNotification object:self.textField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfeildEndEdit) name:UITextFieldTextDidEndEditingNotification object:self.textField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:self.textField];
    
    [self initConfig];
}

- (void)initConstraints {
    [self addSubview:self.textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(self.inset);
    }];
}

- (void)initConfig {
    _digist = 2;
    
    _leftFont = kFontRegular(15);
    _rightFont = kFontRegular(14);
    _textPadding = 5;
    _leftDistance = -1;
    _inset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    _borderWidth = 0.5;
    _borderColor = kColor(0xd1e1f2);
    _hoverColor = kColor(0x23c0af);
    _cursorColor = kColor(0x23c0af);
    
    _showUnderline = NO;
    _underlineHeight = 0.5;
    _underlineInset = UIEdgeInsetsZero;
    _underlineColor = kColor(0xeff2f6);
    
    _placeHolderFont = kFontRegular(14);
    _placeHolderColor = kColor(0xa2a8c3);
    
    [self showBorder];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat maxW = _textField.frame.size.width;
    CGFloat maxH = _textField.frame.size.height;
    if (maxW == 0 && maxH == 0) return;
    
    
    
    /// 系统版本小于iOS13.0的代码新特性
    if (kSystemVersion < 13.0) {
        if (_leftTitle) {
            CGFloat w = [_leftTitle zt_textSizeWithConstraintSize:CGSizeMake(maxW, maxH) font:_leftFont].width;
            
            CGFloat leftW = w + 5;
            if (_leftDistance >= 0) {
                leftW = w + _leftDistance;
            }
            
            CGFloat x = 0;
            if (_textField.leftView) {
                x = CGRectGetMinX(_textField.leftView.frame);
            }
            self.leftLabel.frame = CGRectMake(x, 0, leftW, maxH);
        }
        
        if (_rightTitle) {
            CGFloat w = [_rightTitle zt_textSizeWithConstraintSize:CGSizeMake(maxW, maxH) font:_rightFont].width;
            
            CGFloat x = 0;
            if (_textField.rightView) {
                x = CGRectGetMinX(_textField.rightView.frame);
            }
            self.rightLabel.frame = CGRectMake(x, 0, w + 5, maxH);
        }
    }
    
    // 处理下划线
    if (_showUnderline) {
        CGFloat X = 0 + _underlineInset.left;
        CGFloat Y = maxH - _underlineHeight;
        CGFloat W = self.frame.size.width - _underlineInset.left - _underlineInset.right;
        self.underLine.frame = CGRectMake(X, Y, W, _underlineHeight);
    }
}

- (void)showBorder {
    if (_borderWidth > 0) {
        self.layer.borderWidth = _borderWidth;
        self.layer.borderColor = _borderColor.CGColor;
    }
    else {
        self.layer.borderWidth = 0;
    }
}


#pragma mark - Public

- (void)addFilterType:(kInputFilterType)type content:(nullable id)content {
    _inputFilterType = type;
    
    switch (_inputFilterType) {
        case kInputFilterType_custom:
            NSAssert(content, @"自定义类型需要传入正则");
            NSAssert([content isKindOfClass:[NSString class]], @"自定义类型需要传入正则");
            _regex = content;
            break;
        case kInputFilterType_decimalNumber:
            NSAssert([content isKindOfClass:[NSString class]] ||
                     [content isKindOfClass:[NSNumber class]], @"对于‘kInputFilterType_decimalNumber’类型，content 仅支持 NSString 和 NSNumber 类型");
            if (content) {
                NSUInteger digi = [content integerValue];
                if (digi > 0) {
                    _digist = digi;
                }
            }
            break;
            
        default:
            break;
    }
}

- (void)bindRightAction:(void(^)(id))action {
    _rightClickBlock = action;
    
    self.rightLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [_rightLabel addGestureRecognizer:tapGesture];
}

#pragma mark - Action

- (void)tapClick {
    if (_rightClickBlock) {
        _rightClickBlock(_rightLabel);
    }
}

#pragma mark - Notification

- (void)textfeildBeginEdit {
    if (_borderWidth > 0) {
        self.layer.borderColor = _hoverColor.CGColor;
    }
    
    if (_showUnderline) {
        _underLine.backgroundColor = _underlineHoverColor;
    }
}

- (void)textfeildEndEdit {
    if (_borderWidth > 0) {
        self.layer.borderColor = _borderColor.CGColor;
    }
    
    if (_showUnderline) {
        _underLine.backgroundColor = _underlineColor;
    }
}

- (void)textDidChange {
    NSLog(@"===\(tempText) ===\(textfield.text!)");
    if (_inputFilterType == kInputFilterType_none) return;
    
    NSString *text = _textField.text;
    
    switch (_inputFilterType) {
        case kInputFilterType_number:
            if (![text isEqual:@""] && ![text my_isNumber]) {
                _textField.text = _tempText;
            }
            break;
        case kInputFilterType_positveNumber:
            if (![text isEqual:@""] && ![text my_isPositiveNumber]) {
                _textField.text = _tempText;
            }
            break;
        case kInputFilterType_decimalNumber:
            if (![text isEqual:@""] && ![text my_filterDecimalNumber:_digist]) {
                _textField.text = _tempText;
            }
            break;
        case kInputFilterType_custom:
            if (![text isEqual:@""] && ![text my_matchCustomRegex:_regex]) {
                _textField.text = _tempText;
            }
            break;
            
        default:
            break;
    }
    
    _tempText = _textField.text;
}

#pragma mark - Setter and Getter

- (void)setTextPadding:(CGFloat)textPadding {
    _textPadding = textPadding;
    self.textField.padding = textPadding;
}

- (void)setInset:(UIEdgeInsets)inset {
    _inset = inset;
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(inset);
    }];
}

- (void)setLeftTitle:(NSString *)leftTitle {
    _leftTitle = leftTitle;
    self.leftLabel.text = leftTitle;
    self.textField.leftView = _leftLabel;
    [self setNeedsLayout];
}

- (void)setLeftFont:(UIFont *)leftFont {
    _leftFont = leftFont;
    self.leftLabel.font = leftFont;
}

- (void)setLeftColor:(UIColor *)leftColor {
    _leftColor = leftColor;
    self.leftLabel.textColor = leftColor;
}

- (void)setLeftAttriTitle:(NSAttributedString *)leftAttriTitle {
    _leftAttriTitle = leftAttriTitle;
    _leftTitle = leftAttriTitle.string;
    self.leftLabel.attributedText = leftAttriTitle;
    [self setNeedsLayout];
}

- (void)setRightTitle:(NSString *)rightTitle {
    _rightTitle = rightTitle;
    self.rightLabel.text = rightTitle;
    self.textField.rightView = _rightLabel;
    [self setNeedsLayout];
}

- (void)setRightColor:(UIColor *)rightColor {
    _rightColor = rightColor;
    self.rightLabel.textColor = rightColor;
}

- (void)setRightFont:(UIFont *)rightFont {
    _rightFont = rightFont;
    self.rightLabel.font = rightFont;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:placeHolder];
    [attri addAttributes:@{NSFontAttributeName: _placeHolderFont} range:NSMakeRange(0, placeHolder.length)];
    [attri addAttributes:@{NSForegroundColorAttributeName: _placeHolderColor} range:NSMakeRange(0, placeHolder.length)];
    self.textField.attributedPlaceholder = attri;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderCorner:(CGFloat)borderCorner {
    _borderCorner = borderCorner;
    self.layer.cornerRadius = borderCorner;
}

- (void)setCursorColor:(UIColor *)cursorColor {
    _cursorColor = cursorColor;
    self.textField.tintColor = cursorColor;
}

- (void)setUnderlineColor:(UIColor *)underlineColor {
    _underlineColor = underlineColor;
    self.underLine.backgroundColor = underlineColor;
}

- (void)setShowUnderline:(BOOL)showUnderline {
    _showUnderline = showUnderline;
    if (showUnderline) {
        _borderWidth = 0;
        [self showBorder];
    }
}


#pragma mark - Lazy

- (MYTextField *)textField {
    if (!_textField) {
        _textField = [MYTextField new];
        _textField.textColor = kColor(0x242c4d);
        _textField.font = kFontMedium(16);
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _leftLabel.textColor = kColor(0x242c4d);
        _leftLabel.font = kFontRegular(15);
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _rightLabel.textColor = kColor(0x677197);
        _rightLabel.font = kFontMedium(14);
    }
    return _rightLabel;
}

- (UIView *)underLine {
    if (!_underLine) {
        _underLine = [UIView new];
        _underLine.backgroundColor = _underlineColor;
        [self addSubview:_underLine];
    }
    return _underLine;
}

@end



@implementation MYTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _padding = 5;
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    rect.size.width -= _padding*2;
    
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super editingRectForBounds:bounds];
    rect.size.width -= _padding*2;
    
    return rect;
}

@end
