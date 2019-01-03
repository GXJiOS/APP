//
//  DTCycleView.h
//  AppDemo
//
//  Created by GXJ on 2017/4/20.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DTCycleViewScrollDirection) {
    DTCycleViewScrollDirectionHorizontal,
    DTCycleViewScrollDirectionVertical
};

typedef NS_ENUM(NSInteger,DTCycleViewScrollType) {
    DTCycleViewScrollTypeNormal,
    DTCycleViewScrollTypeParallex
};

@protocol DTCyleViewCustomViewDataSource <NSObject>
- (NSInteger)DTCycleViewItemCount;
- (UICollectionViewCell *)DTCycleCustomCellAdjustDataWithCell:(UICollectionViewCell *)cell itemIndex:(NSInteger)index;
- (NSString *)DTCycleViewCustomCellReuseKey;
- (Class)DTCycleViewCustomCellClass;
@end

@protocol DTCyleViewCustomViewDelegate <NSObject>
@optional
- (void)DTCycleViewClickIndex:(NSInteger)index;
@end

@interface DTCycleView : UIView

- (instancetype)initWithRuseKey:(NSString *)ruseKey;
/** 本地图片数组 */
@property (nonatomic,copy) NSArray <NSString *>*localImageNameArray;
/** 网络图片数组 */
@property (nonatomic,copy) NSArray <NSString *>*netImageUrlStringArray;
/** 自动播放的时间间隔 */
@property (nonatomic,assign) NSTimeInterval repeatTime;
/** 缺省图 */
@property (nonatomic,strong) UIImage *placeholderImage;
/** 隐藏pageControl */
@property (nonatomic,assign) BOOL isPageControlHidden;
/** 是否可以滑动 */
@property (nonatomic,assign) BOOL isScrollEnable;
/** 滑动的方向 (默认水平滑动) */
@property (nonatomic,assign) DTCycleViewScrollDirection scrollDirection;
/** 滚动模式 (默认滚动和视差滚动,默认是默认滚动,视差滚动只能水平滚动) */
@property (nonatomic,assign) DTCycleViewScrollType scrollType;
/** 自定义内容样式的数据源 */
@property (nonatomic,weak) id <DTCyleViewCustomViewDataSource> dataSource;
/** 代理 */
@property (nonatomic,weak) id <DTCyleViewCustomViewDelegate> delegate;
//-- tabber切换的时候如果正好在做动画那么会卡顿,推测runloop的问题,需要外部对timer做一些判断
- (void)stopTimer;
- (void)startTimer;
/** 刷新数据,不是自定义样式的情况下设置array是默认刷新 */
- (void)dt_customReloadData;
@end

// ----------------------------------------------
// ----------------------------------------------
// ----------------------- cell -----------------------
@interface DTCycleViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *contentImageView;
@property (nonatomic,assign) CGFloat parallex;
- (void)adjustContentImageView;
+ (instancetype)dtCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath reuseKey:(NSString *)reuseKey;
@end
