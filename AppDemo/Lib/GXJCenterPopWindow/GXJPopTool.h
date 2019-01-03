//
//  Created by GXJ on 2016/10/25.
//  Copyright © 2016年 GXJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  关闭按钮的位置
 */
#define GXJPopToolInstance [GXJPopTool sharedInstance]

typedef NS_ENUM(NSInteger, ButtonPositionType) {
    /**
     *  无
     */
    ButtonPositionTypeNone = 0,
    /**
     *  左上角
     */
    ButtonPositionTypeLeft = 1 << 0,
    /**
     *  右上角
     */
    ButtonPositionTypeRight = 2 << 0
};
/**
 *  蒙板的背景色
 */
typedef NS_ENUM(NSInteger, ShadeBackgroundType) {
    /**
     *  渐变色
     */
    ShadeBackgroundTypeGradient = 0,
    /**
     *  固定色
     */
    ShadeBackgroundTypeSolid = 1 << 0
};

typedef void(^completeBlock)(void);

@protocol GXJPopToolDelegate <NSObject>

@optional
-(void)closeAction;

@end

@interface GXJPopTool : NSObject

@property (nonatomic,weak) id <GXJPopToolDelegate> delegate;
@property (strong, nonatomic) UIColor *popBackgroudColor;//弹出视图的背景色
@property (assign, nonatomic) BOOL tapOutsideToDismiss;//点击蒙板是否弹出视图消失
@property (assign, nonatomic) ButtonPositionType closeButtonType;//关闭按钮的类型
@property (assign, nonatomic) ShadeBackgroundType shadeBackgroundType;//蒙板的背景色
@property (assign, nonatomic) BOOL closeAnimated;

/**
 *  创建一个实例
 *
 *  @return GXJPopTool
 */
+ (GXJPopTool *)sharedInstance;
/**
 *  弹出要展示的View
 *
 *  @param presentView show View
 *  @param animated    是否动画
 */
- (void)showWithPresentView:(UIView *)presentView animated:(BOOL)animated;
/**
 *  关闭弹出视图
 *
 *  @param complete complete block
 */
- (void)closeWithBlcok:(void(^)())complete;

@end

