//
//  ViewController.m
//  Demo_OC
//
//  Created by MayerF on 2020/8/13.
//  Copyright © 2020 MayerF. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "MYLeftRightTextFieldView.h"
#import "Macros.h"

@interface ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *close;
@property (nonatomic, strong) UILabel *summaryLabel;

@property (nonatomic, strong) UILabel *titleLabel1;
@property (nonatomic, strong) MYLeftRightTextFieldView *textFieldView1;

@property (nonatomic, strong) UILabel *titleLabel2;
@property (nonatomic, strong) MYLeftRightTextFieldView *textFieldView2;

@property (nonatomic, strong) UILabel *titleLabel3;
@property (nonatomic, strong) MYLeftRightTextFieldView *textFieldView3;

@property (nonatomic, strong) UILabel *titleLabel4;
@property (nonatomic, strong) MYLeftRightTextFieldView *textFieldView4;

@property (nonatomic, strong) UILabel *titleLabel5;
@property (nonatomic, strong) MYLeftRightTextFieldView *textFieldView5;

@property (nonatomic, strong) UILabel *titleLabel6;
@property (nonatomic, strong) MYLeftRightTextFieldView *textFieldView6;

@property (nonatomic, strong) UILabel *titleLabel7;
@property (nonatomic, strong) MYLeftRightTextFieldView *textFieldView7;

@property (nonatomic, strong) UILabel *titleLabel8;
@property (nonatomic, strong) MYLeftRightTextFieldView *textFieldView8;

@property (nonatomic, strong) UILabel *titleLabel9;
@property (nonatomic, strong) MYLeftRightTextFieldView *textFieldView9;

@property (nonatomic, strong) UILabel *titleLabel10;
@property (nonatomic, strong) MYLeftRightTextFieldView *textFieldView10;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;

    [self initCommon];
    [self initConstraints];
}

- (void)initCommon {
    _scrollView = [UIScrollView new];
    _contentView = [UIView new];
    _close = [UIButton new];
    _summaryLabel = [UILabel new];
    
    _titleLabel1 = [UILabel new];
    _textFieldView1 = [MYLeftRightTextFieldView new];
    
    _titleLabel2 = [UILabel new];
    _textFieldView2 = [MYLeftRightTextFieldView new];
    
    _titleLabel3 = [UILabel new];
    _textFieldView3 = [MYLeftRightTextFieldView new];
    
    _titleLabel4 = [UILabel new];
    _textFieldView4 = [MYLeftRightTextFieldView new];
    
    _titleLabel5 = [UILabel new];
    _textFieldView5 = [MYLeftRightTextFieldView new];
    
    _titleLabel6 = [UILabel new];
    _textFieldView6 = [MYLeftRightTextFieldView new];
    
    _titleLabel7 = [UILabel new];
    _textFieldView7 = [MYLeftRightTextFieldView new];
    
    _titleLabel8 = [UILabel new];
    _textFieldView8 = [MYLeftRightTextFieldView new];
    
    _titleLabel9 = [UILabel new];
    _textFieldView9 = [MYLeftRightTextFieldView new];
    
    _titleLabel10 = [UILabel new];
    _textFieldView10 = [MYLeftRightTextFieldView new];
    
    [_close setTitle:@"关闭键盘" forState:UIControlStateNormal];
    [_close setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [_close addTarget:self action:@selector(closeOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _summaryLabel.text = @"一、可定制边框颜色、hover颜色和光标颜色\n二、可以统一指定输入过程的过滤规则，如果需要更细度的过滤规则，则需要在代理回调方法中自定义处理\n三、没有边框仅有下划线的UI样式";
    _summaryLabel.font = kFontRegular(13);
    _summaryLabel.textColor = kColor(0x23c0af);
    _summaryLabel.numberOfLines = 0;
    
    // 1
    _titleLabel1.text = @"1. 左侧文本，右侧文本，中间输入框";
    _titleLabel1.font = kFontRegular(13);
    _textFieldView1.leftTitle = @"金额";
    _textFieldView1.rightTitle = @"CNY";
    _textFieldView1.placeHolder = @"请输入金额";
    _textFieldView1.textPadding = 20;
    _textFieldView1.borderCorner = 5;
    _textFieldView1.borderColor = kColor(0xd1e1f2);
    _textFieldView1.hoverColor = kColor(0x23c0af);
    _textFieldView1.cursorColor = kColor(0x23c0af);
    
    // 2
    _titleLabel2.text = @"2. 左侧可变文本，右侧文本";
    _titleLabel2.font = kFontRegular(13);
    NSMutableAttributedString *attM = [[NSMutableAttributedString alloc] initWithString:@"姓名(仅支持英文)"];
    NSRange range = [attM.string rangeOfString:@"(仅支持英文)"];
    if (range.location != NSNotFound) {
        [attM addAttributes:@{NSFontAttributeName: kFontMedium(15),
                              NSForegroundColorAttributeName: kColor(0x23c0af)
        } range:range];
        _textFieldView2.leftAttriTitle = attM;
    }
    _textFieldView2.borderCorner = 5;
    _textFieldView2.rightTitle = @"LeftRightTextFieldView";
    [_textFieldView2.textField setEnabled:NO];
    
    // 3
    _titleLabel3.text = @"3. 右侧文本，中间输入框";
    _titleLabel3.font = kFontRegular(13);
    _textFieldView3.rightTitle = @"CNY";
    _textFieldView3.placeHolder = @"请输入最大金额";
    _textFieldView3.borderCorner = 5;
    _textFieldView3.textField.textAlignment = NSTextAlignmentLeft;
    _textFieldView3.borderColor = kColor(0xd1e1f2);
    _textFieldView3.hoverColor = kColor(0x23c0af);
    _textFieldView3.cursorColor = kColor(0x23c0af);
    
    // 4
    _titleLabel4.text = @"4. 左侧文本，中间输入框,右侧可点击文本，且中间输入起始点距离左侧固定宽度";
    _titleLabel4.font = kFontRegular(13);
    _titleLabel4.numberOfLines = 0;
    _textFieldView4.leftTitle = @"手机验证";
    _textFieldView4.rightTitle = @"获取验证码";
    _textFieldView4.placeHolder = @"请输入手机号码";
    _textFieldView4.leftDistance = 90;
    _textFieldView4.borderCorner = 5;
    _textFieldView4.rightColor = kColor(0x23c0af);
    _textFieldView4.textField.textAlignment = NSTextAlignmentLeft;
    _textFieldView4.borderColor = kColor(0xd1e1f2);
    _textFieldView4.hoverColor = kColor(0x23c0af);
    _textFieldView4.cursorColor = kColor(0x23c0af);
    [_textFieldView4 bindRightAction:^(UILabel *rightLabel) {
        rightLabel.text = @"正在获取验证码...";
    }];
    
    // 5
    _titleLabel5.text = @"5. 仅有输入框";
    _titleLabel5.font = kFontRegular(13);
    _textFieldView5.placeHolder = @"请输入验证码";
    _textFieldView5.borderCorner = 5;
    _textFieldView5.textField.textAlignment = NSTextAlignmentCenter;
    _textFieldView5.borderColor = kColor(0xd1e1f2);
    _textFieldView5.hoverColor = kColor(0x23c0af);
    _textFieldView5.cursorColor = kColor(0x23c0af);
    
    // 6
    _titleLabel6.text = @"6. 左侧文本，右侧文本，中间输入框基础上调整两侧边距且去除边框圆角";
    _titleLabel6.font = kFontRegular(13);
    _titleLabel6.numberOfLines = 0;
    _textFieldView6.leftTitle = @"金额";
    _textFieldView6.rightTitle = @"CNY";
    _textFieldView6.placeHolder = @"请输入金额";
    _textFieldView6.inset = UIEdgeInsetsMake(0, 30, 0, 30);
    _textFieldView6.borderColor = kColor(0xd1e1f2);
    _textFieldView6.hoverColor = kColor(0x23c0af);
    _textFieldView6.cursorColor = kColor(0x23c0af);
    
    // 7
    _titleLabel7.text = @"7. 输入框过滤非纯数字";
    _titleLabel7.font = kFontRegular(13);
    _textFieldView7.leftTitle = @"金额";
    _textFieldView7.rightTitle = @"CNY";
    _textFieldView7.placeHolder = @"非[0-9]皆不可输入";
    [_textFieldView7 addFilterType:kInputFilterType_number content:nil];
    _textFieldView7.borderColor = kColor(0xd1e1f2);
    _textFieldView7.hoverColor = kColor(0x23c0af);
    _textFieldView7.cursorColor = kColor(0x23c0af);
    
    // 8
    _titleLabel8.text = @"8. 输入框过滤非正整数";
    _titleLabel8.font = kFontRegular(13);
    _textFieldView8.leftTitle = @"金额";
    _textFieldView8.rightTitle = @"CNY";
    _textFieldView8.placeHolder = @"只能输入非正整数";
    [_textFieldView8 addFilterType:kInputFilterType_positveNumber content:nil];
    _textFieldView8.borderColor = kColor(0xd1e1f2);
    _textFieldView8.hoverColor = kColor(0x23c0af);
    _textFieldView8.cursorColor = kColor(0x23c0af);
    
    // 9
    _titleLabel9.text = @"9. 输入框过滤 仅支持数字或小数，且保留2小数位数";
    _titleLabel9.font = kFontRegular(13);
    _textFieldView9.leftTitle = @"金额";
    _textFieldView9.rightTitle = @"CNY";
    _textFieldView9.placeHolder = @"仅支持数字或小数，且保留2小数位数";
    [_textFieldView9 addFilterType:kInputFilterType_decimalNumber content:@(2)];
    _textFieldView9.borderColor = kColor(0xd1e1f2);
    _textFieldView9.hoverColor = kColor(0x23c0af);
    _textFieldView9.cursorColor = kColor(0x23c0af);
    
    // 10
    _titleLabel10.text = @"10. 没有边框且底部仅有下划线，下划线自由扩展";
    _titleLabel10.font = kFontRegular(13);
    _textFieldView10.backgroundColor = UIColor.clearColor;
    _textFieldView10.showUnderline = true;
    _textFieldView10.underlineHeight = 5;
    _textFieldView10.underlineInset = UIEdgeInsetsMake(0, 20, 0, -10);
    _textFieldView10.underlineHoverColor = kColor(0x23c0af);
    _textFieldView10.rightTitle = @"获取验证码";
    _textFieldView10.placeHolder = @"请输入验证码";
    _textFieldView10.textField.textAlignment = NSTextAlignmentLeft;
    _textFieldView10.rightColor = kColor(0x23c0af);
    [_textFieldView10 bindRightAction:^(UILabel *rightLabel) {
        rightLabel.text = @"正在获取验证码...";
    }];
}

- (void)initConstraints {
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_contentView];
    
    [_contentView addSubview:_close];
    [_contentView addSubview:_summaryLabel];
    
    [_contentView addSubview:_titleLabel1];
    [_contentView addSubview:_textFieldView1];
    
    [_contentView addSubview:_titleLabel2];
    [_contentView addSubview:_textFieldView2];
    
    [_contentView addSubview:_titleLabel3];
    [_contentView addSubview:_textFieldView3];
    
    [_contentView addSubview:_titleLabel4];
    [_contentView addSubview:_textFieldView4];
    
    [_contentView addSubview:_titleLabel5];
    [_contentView addSubview:_textFieldView5];
    
    [_contentView addSubview:_titleLabel6];
    [_contentView addSubview:_textFieldView6];
    
    [_contentView addSubview:_titleLabel7];
    [_contentView addSubview:_textFieldView7];
    
    [_contentView addSubview:_titleLabel8];
    [_contentView addSubview:_textFieldView8];
    
    [_contentView addSubview:_titleLabel9];
    [_contentView addSubview:_textFieldView9];
    
    [_contentView addSubview:_titleLabel10];
    [_contentView addSubview:_textFieldView10];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.textFieldView10).offset(250);
    }];
    
    [_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(60);
    }];
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.close.mas_bottom);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];

    [_titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.summaryLabel.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self.summaryLabel);
    }];
    [_textFieldView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel1.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.summaryLabel);
        make.height.mas_equalTo(44);;
    }];
    
    [_titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textFieldView1.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self.summaryLabel);
    }];
    [_textFieldView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel2.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.summaryLabel);
        make.height.mas_equalTo(44);;
    }];
    
    [_titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textFieldView2.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self.summaryLabel);
    }];
    [_textFieldView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel3.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.summaryLabel);
        make.height.mas_equalTo(44);;
    }];

    [_titleLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textFieldView3.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self.summaryLabel);
    }];
    [_textFieldView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel4.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.summaryLabel);
        make.height.mas_equalTo(44);;
    }];
    
    [_titleLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textFieldView4.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self.summaryLabel);
    }];
    [_textFieldView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel5.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.summaryLabel);
        make.height.mas_equalTo(44);;
    }];
    
    [_titleLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textFieldView5.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self.summaryLabel);
    }];
    [_textFieldView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel6.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.summaryLabel);
        make.height.mas_equalTo(44);;
    }];
    
    [_titleLabel7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textFieldView6.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self.summaryLabel);
    }];
    [_textFieldView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel7.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.summaryLabel);
        make.height.mas_equalTo(44);;
    }];
    
    [_titleLabel8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textFieldView7.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self.summaryLabel);
    }];
    [_textFieldView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel8.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.summaryLabel);
        make.height.mas_equalTo(44);;
    }];
    
    [_titleLabel9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textFieldView8.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self.summaryLabel);
    }];
    [_textFieldView9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel9.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.summaryLabel);
        make.height.mas_equalTo(44);;
    }];
    
    [_titleLabel10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textFieldView9.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self.summaryLabel);
    }];
    [_textFieldView10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel10.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.summaryLabel);
        make.height.mas_equalTo(44);;
    }];
}

#pragma mark - Action

- (void)closeOnClick {
    [self.view endEditing:YES];
}

@end
