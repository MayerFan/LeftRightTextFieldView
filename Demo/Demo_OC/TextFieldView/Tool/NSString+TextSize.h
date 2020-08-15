//
//  NSString+TextSize.h
//  Demo_OC
//
//  Created by MayerF on 2020/8/14.
//  Copyright © 2020 MayerF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TextSize)

- (CGSize)zt_textSizeWithConstraintSize:(CGSize)contstraint font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
