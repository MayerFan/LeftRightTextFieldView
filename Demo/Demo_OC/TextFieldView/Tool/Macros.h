//
//  Macros.h
//  Demo
//
//  Created by MayerF on 2020/8/13.
//  Copyright © 2020 MayerF. All rights reserved.
//
//  https://github.com/MayerFan/LeftRightTextFieldView


#ifndef Macros_h
#define Macros_h


#define kFontRegular(x)  [UIFont fontWithName:@"PingFangSC-Regular" size:x]
#define kFontMedium(x)   [UIFont fontWithName:@"PingFangSC-Medium" size:x]

#define kColor(x) kColorHex(x, 1)
#define kColorHex(x, a) [UIColor colorWithRed:(x>>16&0xFF)/255.0 green:(x>>8&0xFF)/255.0 blue:(x&0xFF)/255.0 alpha:a]
#define kColorRGB(a, b, c, d) [UIColor colorWithRed:(a)/255.f green:(b)/255.f blue:(c)/255.f alpha:(d)]


#define kSystemVersion [UIDevice currentDevice].systemVersion.boolValue


#endif /* Macros_h */
