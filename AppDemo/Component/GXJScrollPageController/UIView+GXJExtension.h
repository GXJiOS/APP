//
//  UIView+GXJExtension.h
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GXJExtension)
@property (nonatomic ,assign) CGFloat GXJ_x;
@property (nonatomic ,assign) CGFloat GXJ_y;
@property (nonatomic ,assign) CGFloat GXJ_width;
@property (nonatomic ,assign) CGFloat GXJ_height;
@property (nonatomic ,assign) CGFloat GXJ_centerX;
@property (nonatomic ,assign) CGFloat GXJ_centerY;

@property (nonatomic ,assign) CGSize GXJ_size;

@property (nonatomic, assign) CGFloat GXJ_right;
@property (nonatomic, assign) CGFloat GXJ_bottom;

+ (instancetype)GXJ_viewFromXib;
/** 在分类中声明@property， 只会生成方法的声明， 不会生成方法的实现和带有_线成员变量 */
@end
