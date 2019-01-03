//
//  GXJButtonControl.h
//  AppFrame
//
//  Created by GXJ on 2017/3/29.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GXJButtonControl;
@protocol GXJButtonControlDelegate <NSObject>

- (void)buttonControl:(GXJButtonControl *)control didSelectSegmentAtIndex:(NSInteger)index;

@end

@interface GXJButtonControl : UIView

/**
 *  初始化
 *
 *  @param array          按钮数组
 *  @param isBoder        YES有边框和底色  NO为纯按钮
 *  @param defaultSelect  默认选中 从1开始
 *  @param textFont       文字大小
 *  @param normalColor    文字未选中颜色
 *  @param selectColor    文字选中颜色
 
 */

- (instancetype)initWithArray:(NSArray *)array
                      isBoder:(BOOL)isBoder
                defaultSelect:(NSInteger)defaultSelect
                     textFont:(CGFloat  )textFont
                  normalColor:(UIColor *)normalColor
                  selectColor:(UIColor *)selectColor;

@property (nonatomic, weak)id<GXJButtonControlDelegate>delegate;

@end
