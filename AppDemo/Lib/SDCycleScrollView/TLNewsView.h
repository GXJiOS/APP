//
//  TLNewsView.h
//  AppFrame
//
//  Created by GXJ on 2017/3/14.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLNewsView;

@protocol TLCycleScrollViewDelegate <NSObject>

@optional

/** 点击图片回调 */
- (void)tlcycleScrollView:(TLNewsView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

/** 图片滚动回调 */
- (void)tlcycleScrollView:(TLNewsView *)cycleScrollView didScrollToIndex:(NSInteger)index;

@end

@interface TLNewsView : UIView


//////////////////////  数据源接口  //////////////////////

/** 每张图片对应要显示的文字数组 */
@property (nonatomic, strong) NSArray *titlesGroup;

//////////////////////  滚动控制接口 //////////////////////

/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

/** 是否无限循环,默认Yes */
@property (nonatomic,assign) BOOL infiniteLoop;

/** 是否自动滚动,默认Yes */
@property (nonatomic,assign) BOOL autoScroll;

/** 图片滚动方向，默认为水平滚动 */
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@property (nonatomic, weak) id<TLCycleScrollViewDelegate> delegate;

/** block监听点击方式 */
@property (nonatomic, copy) void (^clickItemOperationBlock)(NSInteger currentIndex);


//////////////////////  清除缓存接口  //////////////////////

/** 清除图片缓存（此次升级后统一使用SDWebImage管理图片加载和缓存）  */
+ (void)clearImagesCache;

/** 清除图片缓存（兼容旧版本方法） */
- (void)clearCache;

@end
