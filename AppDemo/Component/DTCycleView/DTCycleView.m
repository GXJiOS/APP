//
//  DTCycleView.m
//  AppDemo
//
//  Created by GXJ on 2017/4/20.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "DTCycleView.h"
#import "DTSliderPageControl.h"
#import "UIImageView+WebCache.h"
//NSString *const kDTCycleRuseKey = @"kDTCycleRuseKey";
NSInteger const kMaxSectionCount = 100;
CGFloat const kparallexSpeed = 0.5;
@interface DTCycleView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,assign) NSInteger arrayItemCount;
@property (nonatomic,assign) BOOL isNetImage;
@property (nonatomic,assign) NSInteger showingIndex;
@property (nonatomic,strong) UICollectionView *contentCollectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) NSTimer *repeatTimer;
@property (nonatomic,strong) DTSliderPageControl *pageControl;
@property (nonatomic,copy)NSString *cycleRuseKey;
@end

@implementation DTCycleView
#pragma mark - life cycle
- (instancetype)initWithRuseKey:(NSString *)ruseKey {
    if (self = [super init]) {
        self.cycleRuseKey = ruseKey;
        [self addSubview:self.contentCollectionView];
        [self addSubview:self.pageControl];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.dataSource) {
        self.pageControl.hidden = YES;
    }
    if (self.scrollDirection == DTCycleViewScrollDirectionVertical && self.scrollType == DTCycleViewScrollTypeParallex) {
        NSAssert(false, @"DTCycleView视差滑动只支持水平滚动");
    }
    if (self.dataSource) {
        self.arrayItemCount = [self.dataSource DTCycleViewItemCount];
    }
    self.pageControl.frame = CGRectMake(0, self.frame.size.height - 23, self.frame.size.width, 6);
    // 自定义内容的情况
    Class customCellClass =[self.dataSource DTCycleViewCustomCellClass];
    NSString *reuseKey = [self.dataSource DTCycleViewCustomCellReuseKey];
    if (reuseKey && customCellClass) {
        [self.contentCollectionView registerClass:customCellClass forCellWithReuseIdentifier:reuseKey];
    }
    // 滑动方向
    self.flowLayout.scrollDirection = self.scrollDirection == DTCycleViewScrollDirectionHorizontal ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
    // 初始化配置
    self.flowLayout.itemSize = self.bounds.size;
    self.contentCollectionView.frame = self.bounds;
    if (self.localImageNameArray.count > 0 || self.netImageUrlStringArray.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:kMaxSectionCount/2];
        [self.contentCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [self p_addTimer];
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self.repeatTimer invalidate];
        self.repeatTimer = nil;
    }
}

- (void)dealloc {
//    [self.contentCollectionView removeObserver:self forKeyPath:@"contentOffset"];
}
#pragma mark - public methods
- (void)startTimer {
    if (self.repeatTimer) {return;}
    [self p_addTimer];
}

- (void)stopTimer {
    [self.repeatTimer invalidate];
    self.repeatTimer = nil;
}
- (void)dt_customReloadData {
    [self stopTimer];
    self.arrayItemCount = [self.dataSource DTCycleViewItemCount];
    
    [self.contentCollectionView reloadData];
    if (self.arrayItemCount > 0) {
        self.showingIndex = 0;
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForItem:self.showingIndex inSection:kMaxSectionCount/2];
        [self.contentCollectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    [self startTimer];
}
#pragma mark - target action



#pragma mark - delegates
// ----------------------- collectionView datasource -----------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return kMaxSectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource) {
        return [self.dataSource DTCycleViewItemCount];
    }
    if (self.arrayItemCount > 0) {
       return self.arrayItemCount;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self.dataSource DTCycleViewCustomCellReuseKey] forIndexPath:indexPath];
        [self.dataSource DTCycleCustomCellAdjustDataWithCell:cell itemIndex:indexPath.row];
        return cell;
    }else {
        DTCycleViewCell *cell = [DTCycleViewCell dtCellWithCollectionView:collectionView indexPath:indexPath reuseKey:self.cycleRuseKey];
        [cell adjustContentImageView];
        if (self.isNetImage) {
            NSString *webImageString = self.netImageUrlStringArray[indexPath.row];
            [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:webImageString] placeholderImage:self.placeholderImage];
        }else {
            NSString *imageString = self.localImageNameArray[indexPath.row];
            cell.contentImageView.image = [UIImage imageNamed:imageString];
        }
        return cell;
    }
}

// ----------------------- collectionView delegate -----------------------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(DTCycleViewClickIndex:)]) {
        [self.delegate DTCycleViewClickIndex:indexPath.row];
    }
}

// ----------------------- scrollView delegage -----------------------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self p_removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self p_addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 当前展示的index
    int index = 0;
    if (self.scrollDirection == DTCycleViewScrollDirectionHorizontal) {
        index = (int)(scrollView.contentOffset.x / scrollView.frame.size.width) % self.arrayItemCount;
    }
    if (self.scrollDirection == DTCycleViewScrollDirectionVertical) {
        index = (int)(scrollView.contentOffset.y / scrollView.frame.size.height) % self.arrayItemCount;
    }
    self.showingIndex = index;
    
    // 视差滚动
    if (self.scrollType == DTCycleViewScrollTypeParallex ) {
        for (DTCycleViewCell *cell in self.contentCollectionView.visibleCells) {
            CGFloat xOffset = self.contentCollectionView.contentOffset.x - cell.frame.origin.x;
            if (xOffset >= 0) {
                cell.parallex = xOffset;
            }else {
                [cell adjustContentImageView];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.dataSource) {
        return;
    }
    NSArray *cellArray = [self.contentCollectionView visibleCells];
    for (DTCycleViewCell *cell in cellArray) {
        [cell adjustContentImageView];
    }
}

#pragma mark - pravite methods
- (void)p_nextPage {
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForItem:self.showingIndex inSection:kMaxSectionCount/2];
    [self.contentCollectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    NSInteger section = kMaxSectionCount/2;
    self.showingIndex++;
    if (self.showingIndex == self.arrayItemCount) {
        self.showingIndex = 0;
        section++;
    }

    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:self.showingIndex inSection:section];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self layoutIfNeeded];
        [self.contentCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    });
}

- (void)p_addTimer {
    if (self.repeatTimer) {return;}
//    if (self.arrayItemCount < 2) {return;}
    NSTimeInterval time = self.repeatTime <= 0 ? 5 : self.repeatTime;
    self.repeatTimer = [NSTimer timerWithTimeInterval:time target:self selector:@selector(p_nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.repeatTimer forMode:NSRunLoopCommonModes];
}

- (void)p_removeTimer {
    [self.repeatTimer invalidate];
    self.repeatTimer = nil;
}

#pragma mark - setters
- (void)setLocalImageNameArray:(NSArray<NSString *> *)localImageNameArray {
    _localImageNameArray = localImageNameArray;
    self.arrayItemCount = localImageNameArray.count;
    self.isNetImage = NO;
    self.pageControl.pageNumber = localImageNameArray.count;
    [self.contentCollectionView reloadData];
    
    if (!_isPageControlHidden) {
        if (localImageNameArray.count <= 1) {
            self.pageControl.hidden = YES;
            self.contentCollectionView.scrollEnabled = NO;
            [self stopTimer];
        }else {
            self.pageControl.hidden = NO;
            self.contentCollectionView.scrollEnabled = YES;
            [self startTimer];
        }
    }
    
}

- (void)setNetImageUrlStringArray:(NSArray<NSString *> *)netImageUrlStringArray {
    _netImageUrlStringArray = netImageUrlStringArray;
    self.arrayItemCount = netImageUrlStringArray.count;
    self.isNetImage = YES;
    self.pageControl.pageNumber = netImageUrlStringArray.count;
    [self.contentCollectionView reloadData];
    self.showingIndex = 0;
    if (self.netImageUrlStringArray.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:kMaxSectionCount/2];
        [self.contentCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    if (!_isPageControlHidden) {
        if (netImageUrlStringArray.count <= 1) {
            self.pageControl.hidden = YES;
            self.contentCollectionView.scrollEnabled = NO;
            [self stopTimer];
        }else {
            self.pageControl.hidden = NO;
            self.contentCollectionView.scrollEnabled = YES;
            [self startTimer];
        }
    }
    
}

- (void)setIsPageControlHidden:(BOOL)isPageControlHidden {
    _isPageControlHidden = isPageControlHidden;
    self.pageControl.hidden = isPageControlHidden;
}

- (void)setIsScrollEnable:(BOOL)isScrollEnable {
    _isScrollEnable = isScrollEnable;
    self.contentCollectionView.scrollEnabled = isScrollEnable;
}
#pragma mark - getters
- (UICollectionView *)contentCollectionView {
    if (_contentCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.flowLayout = flowLayout;
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.backgroundColor = [UIColor clearColor];
        _contentCollectionView.pagingEnabled = YES;
        _contentCollectionView.scrollsToTop = YES;
        _contentCollectionView.showsVerticalScrollIndicator = NO;
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        [_contentCollectionView registerClass:[DTCycleViewCell class] forCellWithReuseIdentifier:self.cycleRuseKey];
    }
    return _contentCollectionView;
}

- (DTSliderPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[DTSliderPageControl alloc]init];
        _pageControl.controlScrollView = self.contentCollectionView;
        _pageControl.highlightColor = [UIColor whiteColor];
        _pageControl.normalColor = [UIColor colorWithWhite:1 alpha:0.7];
    }
    return _pageControl;
}

@end


// ----------------------------------------------
// ----------------------------------------------
// ----------------------------------------------
@interface DTCycleViewCell()
@end

@implementation DTCycleViewCell
#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.contentImageView.frame = self.bounds;
    [CATransaction commit];
}

#pragma mark - public methods
+ (instancetype)dtCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath reuseKey:(NSString *)reuseKey{
    DTCycleViewCell *cell = (DTCycleViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseKey forIndexPath:indexPath];
    [collectionView bringSubviewToFront:cell];
    return cell;
}

- (void)adjustContentImageView {
    self.contentImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}
#pragma mark - setters
- (void)setParallex:(CGFloat)parallex {
    _parallex = parallex;
    CGRect frame = self.contentImageView.bounds;
    CGRect offsetFrame = CGRectOffset(frame,parallex * kparallexSpeed, 0);
    self.contentImageView.frame = offsetFrame;
}

#pragma mark - getters
- (UIImageView *)contentImageView {
    if (_contentImageView == nil) {
        _contentImageView = [[UIImageView alloc]init];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        _contentImageView.clipsToBounds = YES;
        _contentImageView.backgroundColor = [UIColor clearColor];
    }
    return _contentImageView;
}
@end
