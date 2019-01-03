//
//  GXJTopTitleView.h
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXJPagesViewController.h"

@class GXJTopTitleView;

@protocol GXJTopTitleViewDelegate <NSObject>

- (void)GXJTopTitleView:(GXJTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index;

@end

@interface GXJTopTitleView : UIScrollView
/** 未选中颜色 */
@property (nonatomic,assign)UIColor *normalColor;
/** 选中颜色 */
@property (nonatomic,assign)UIColor *selectColor;
/** 未选中字体 */
@property (nonatomic,assign)CGFloat normalFont;
/** 选中字体 */
@property (nonatomic,assign)CGFloat selectFont;
/** 滚动标题数组 */
@property (nonatomic, strong) NSArray *scrollTitleArr;
/** 存入所有Label */
@property (nonatomic, strong) NSMutableArray *allTitleLabel;
/** 单页显示的标题数 */
@property (nonatomic, assign) NSInteger showNumber;
/** label间隔 */
@property (nonatomic, assign) float labelMargin;
/** 标题长度类型 */
@property (nonatomic, assign) TitleLenthType titleLengthType;

@property (nonatomic, weak) id<GXJTopTitleViewDelegate> delegate_GXJ;

/** 类方法 */
+ (instancetype)topTitleViewWithFrame:(CGRect)frame;

#pragma mark - - - 给外界ScrollView提供的方法以及自身方法实现

/** 滚动标题选中颜色改变以及指示器位置变化 */
- (void)scrollTitleLabelSelecteded:(UILabel *)label;
/** 滚动标题选中居中 */
- (void)scrollTitleLabelSelectededCenter:(UILabel *)centerLabel;
/** 滑动时标题选中居中 */
- (void)scrollTitleLabelScrollCenter:(NSInteger)index ;

@end
