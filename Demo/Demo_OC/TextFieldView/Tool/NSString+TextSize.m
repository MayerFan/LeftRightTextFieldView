//
//  NSString+TextSize.m
//  Demo_OC
//
//  Created by MayerF on 2020/8/14.
//  Copyright © 2020 MayerF. All rights reserved.
//

#import "NSString+TextSize.h"

@implementation NSString (TextSize)

- (CGSize)zt_textSizeWithConstraintSize:(CGSize)contstraint font:(UIFont *)font {
    CGRect rect = [self boundingRectWithSize:contstraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    
    return rect.size;
}

@end
