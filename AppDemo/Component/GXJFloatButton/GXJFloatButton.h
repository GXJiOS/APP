//
//  GXJFloatButton.h
//  AppFrame
//
//  Created by GXJ on 2017/3/29.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height - 64)
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)

typedef NS_ENUM (NSUInteger, LocationTag)
{
    kLocationTag_top = 1,
    kLocationTag_left,
    kLocationTag_bottom,
    kLocationTag_right
};

@interface GXJFloatButton : UIView<UIGestureRecognizerDelegate>
@property (nonatomic, copy) NSString *imageName;//浮标的imageview
@property (nonatomic, assign) BOOL isMoving;//是否可移动 默认YES
@property (nonatomic, assign) BOOL isShadow;//是否有阴影 默认NO

typedef void(^floatButtonBlock)(void);
@property (nonatomic,strong)floatButtonBlock block;

@end
