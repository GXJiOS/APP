//
//  UIView+GXJExtension.m
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "UIView+GXJExtension.h"

@implementation UIView (GXJExtension)
- (void)setGXJ_x:(CGFloat)GXJ_x {
    CGRect frame = self.frame;
    frame.origin.x = GXJ_x;
    self.frame = frame;
}

- (void)setGXJ_y:(CGFloat)GXJ_y {
    CGRect frame = self.frame;
    frame.origin.y = GXJ_y;
    self.frame = frame;
}

- (void)setGXJ_width:(CGFloat)GXJ_width {
    CGRect frame = self.frame;
    frame.size.width = GXJ_width;
    self.frame = frame;
}

- (void)setGXJ_height:(CGFloat)GXJ_height {
    CGRect frame = self.frame;
    frame.size.height = GXJ_height;
    self.frame = frame;
}

- (CGFloat)GXJ_x {
    return self.frame.origin.x;
}

- (CGFloat)GXJ_y {
    return self.frame.origin.y;
}

- (CGFloat)GXJ_width {
    return self.frame.size.width;
}

- (CGFloat)GXJ_height {
    return self.frame.size.height;
}

- (CGFloat)GXJ_centerX {
    return self.center.x;
}
- (void)setGXJ_centerX:(CGFloat)GXJ_centerX {
    CGPoint center = self.center;
    center.x = GXJ_centerX;
    self.center = center;
}

- (CGFloat)GXJ_centerY {
    return self.center.y;
}
- (void)setGXJ_centerY:(CGFloat)GXJ_centerY {
    CGPoint center = self.center;
    center.y = GXJ_centerY;
    self.center = center;
}

- (void)setGXJ_size:(CGSize)GXJ_size {
    CGRect frame = self.frame;
    frame.size = GXJ_size;
    self.frame = frame;
}
- (CGSize)GXJ_size {
    return self.frame.size;
}


- (CGFloat)GXJ_right {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)GXJ_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setGXJ_right:(CGFloat)GXJ_right {
    self.GXJ_x = GXJ_right - self.GXJ_width;
}
- (void)setGXJ_bottom:(CGFloat)GXJ_bottom {
    self.GXJ_y = GXJ_bottom - self.GXJ_height;
}

+ (instancetype)GXJ_viewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

@end
