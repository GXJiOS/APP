//
//  XJNavigationMenuView.h
//  DTHybridFrameworkDemo
//
//  Created by GXJ on 2017/9/22.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XJNavigationMenuView;

@protocol XJNavigationMenuViewDelegate <NSObject>

@optional

/**
 点击每一栏时通过代理回调
 
 @param menuView self
 @param index 每一栏的索引,从0开始,
 */
- (void)navigationMenuView:(XJNavigationMenuView *)menuView clickedAtIndex:(NSInteger)index;

@end

@interface XJNavigationMenuView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) id<XJNavigationMenuViewDelegate>delegate;

@property (nonatomic,assign)BOOL isShow;

/**
 点击每一栏时通过block回调,索引从0开始,
 */
@property (nonatomic, copy) void (^clickedBlock)(NSInteger index);

/**
 初始化对象
 
 @param point 箭头指向的位置
 @param imageArray image对象或者图片名称
 @param titleArray 显示的标题, titleArray和imageArray的个数需保持一致
 @param backColor 菜单的背景色
 @param titleColor  字体颜色
 @return 初始化对象
 */
- (instancetype)initWithPositionOfDirection:(CGPoint)point images:(NSArray *)imageArray titleArray:(NSArray<NSString *> *)titleArray backColor:(UIColor *)backColor titleColor:(UIColor *)titleColor;

- (void)disMissSelf;

@end

