//
//  VerticalAdScrollView.h
//  zjGovernment
//
//  Created by GXJ on 2017/5/10.
//  Copyright © 2017年 胡胜冬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerticalView.h"

@protocol VerticalAdScrollDataSource;
@protocol VerticalAdScrollDelegate;

@interface VerticalAdScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic,assign) BOOL needsReload;

/**
 *  一页的尺寸
 */
@property (nonatomic,assign) CGSize pageSize;
/**
 *  总页数
 */
@property (nonatomic,assign) NSInteger pageCount;

@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,assign) NSRange visibleRange;
/**
 *  如果以后需要支持reuseIdentifier，这边就得使用字典类型了
 */
@property (nonatomic,strong) NSMutableArray *reusableCells;

@property (nonatomic,assign)   id <VerticalAdScrollDataSource> dataSource;
@property (nonatomic,assign)   id <VerticalAdScrollDelegate>   delegate;

/**
 *  指示器
 */
@property (nonatomic,retain)  UIPageControl *pageControl;

/**
 *  非当前页的透明比例
 */
@property (nonatomic, assign) CGFloat minimumPageAlpha;

/**
 *  非当前页的缩放比例
 */
//@property (nonatomic, assign) CGFloat minimumPageScale;

/**
 *  是否开启自动滚动,默认为开启
 */
@property (nonatomic, assign) BOOL isOpenAutoScroll;

/**
 *  是否开启无限轮播,默认为开启
 */
@property (nonatomic, assign) BOOL isCarousel;

/**
 *  当前是第几页
 */
@property (nonatomic, assign, readonly) NSInteger currentPageIndex;

/**
 *  定时器
 */
@property (nonatomic, weak) NSTimer *timer;

/**
 *  自动切换视图的时间,默认是5.0
 */
@property (nonatomic, assign) CGFloat autoTime;

/**
 *  原始页数
 */
@property (nonatomic, assign) NSInteger orginPageCount;

/**
 *  刷新视图
 */
- (void)reloadData;

/**
 *  获取可重复使用的Cell
 */
- (UIView *)dequeueReusableCell;

/**
 *  滚动到指定的页面
 */
- (void)scrollToVerticalPage:(NSUInteger)pageNumber;

/**
 *  开启定时器
 */
- (void)startTimer;

/**
 *  关闭定时器,关闭自动滚动(外部调用)
 */
- (void)closeTimer;

@end


@protocol  VerticalAdScrollDelegate<NSObject>

/**
 *  单个子控件的Size
 */
- (CGSize)sizeForVerticalPageInFlowView:(VerticalAdScrollView *)flowView;

@optional
/**
 *  滚动到了某一列
 */
- (void)didScrollToVerticalPage:(NSInteger)pageNumber inFlowView:(VerticalAdScrollView *)flowView;

/**
 *  点击了第几个cell
 *
 *  @param subView 点击的控件
 *  @param subIndex    点击控件的index
 *
 */
- (void)didSelectVerticalCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex;

@end


@protocol VerticalAdScrollDataSource <NSObject>

/**
 *  返回显示View的个数
 */
- (NSInteger)numberOfVerticalPagesInFlowView:(VerticalAdScrollView *)flowView;

/**
 *  给某一列设置属性
 */
- (UIView *)flowView:(VerticalAdScrollView *)flowView cellForVerticalPageAtIndex:(NSInteger)index;


@end
