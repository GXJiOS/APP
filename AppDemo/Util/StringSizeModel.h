//
//  StringSizeModel.h
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringSizeModel : NSObject

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW;
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font;

@end
