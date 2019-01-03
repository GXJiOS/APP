//
//  DTSliderPageControl.h
//  AppDemo
//
//  Created by GXJ on 2017/4/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTSliderPageControl : UIView
/** 显示的个数 */
@property (nonatomic,assign) NSInteger pageNumber;
/** 普通的颜色 */
@property (nonatomic,strong) UIColor *normalColor;
/** 高亮的颜色 */
@property (nonatomic,strong) UIColor *highlightColor;
/** 控制动画的滑动view */
@property (nonatomic,weak) UIScrollView *controlScrollView;

@property (nonatomic,assign) BOOL isNormalType;
@end
