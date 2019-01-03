//
//  UIViewController+Swizzle.h
//  AppDemo
//
//  Created by GXJ on 2018/9/5.
//  Copyright © 2018年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Swizzle)
@property(nonatomic,assign) CFAbsoluteTime viewLoadStartTime;
@end
