//
//  DTSliderPageControl.m
//  AppDemo
//
//  Created by GXJ on 2017/4/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "DTSliderPageControl.h"
CGFloat const itemWH = 6;
CGFloat const itemPadding = 6;
@interface DTSliderPageControl()
@property (nonatomic,strong) NSMutableDictionary *itemDict;
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UIView *sliderItemView;
@end


@implementation DTSliderPageControl

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.containerView];
    [self p_setUpFrames];
    [self.controlScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)dealloc {
    [self.controlScrollView removeObserver:self forKeyPath:@"contentOffset"];
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"] && [object isEqual:self.controlScrollView]) {
        if (self.pageNumber <= 0) {return;}
        CGFloat count = (int)self.controlScrollView.contentOffset.x/self.controlScrollView.frame.size.width;
        int showingNum = (int)count % self.pageNumber;
        CGFloat percent = count - ((int)(count/self.pageNumber) * self.pageNumber + showingNum);
        UIView *itemView = [self.itemDict valueForKey:[NSString stringWithFormat:@"%d",showingNum]];
        if (percent == 0) {
            self.sliderItemView.frame = itemView.frame;
        }
    
        if (percent < 0) {return;}
        if (showingNum >= self.pageNumber - 1) {return;}
        
        if (percent <= 0.5) {
            CGFloat sliderWidth = itemWH + (itemWH + itemPadding) * 2 * percent;
            if (self.isNormalType) {
                self.sliderItemView.frame = CGRectMake(itemView.frame.origin.x, itemView.frame.origin.y, itemView.frame.size.width, itemView.frame.size.height);
            } else {
                self.sliderItemView.frame = CGRectMake(itemView.frame.origin.x, itemView.frame.origin.y, sliderWidth, itemView.frame.size.height);
            }
        }
        if (percent > 0.5) {
            CGFloat sliderWidth = itemWH * 2 + itemPadding - (itemWH + itemPadding) * (percent - 0.5) * 2;
            CGFloat sliderX = itemView.frame.origin.x + (itemWH * 2 + itemPadding) - sliderWidth;
            if (self.isNormalType) {
                self.sliderItemView.frame = CGRectMake(sliderX, itemView.frame.origin.y, itemView.frame.size.width, itemView.frame.size.height);
            } else {
                self.sliderItemView.frame = CGRectMake(sliderX, itemView.frame.origin.y, sliderWidth, itemView.frame.size.height);
            }
        }
    }
}

#pragma mark - pravite methods
- (void)p_setUpFrames {
    NSInteger itemCount = self.itemDict.allValues.count;
    CGFloat maxWidth = itemWH * self.pageNumber + (self.pageNumber - 1) * itemWH;
    self.containerView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.containerView.bounds = CGRectMake(0, 0, maxWidth, self.frame.size.height);
    for (int index = 0; index < itemCount; index++) {
        UIView *itemView = [self.itemDict valueForKey:[NSString stringWithFormat:@"%d",index]];
        itemView.backgroundColor = self.normalColor == nil ? [UIColor whiteColor] : self.normalColor;
        CGFloat itemX = (itemPadding + itemWH) * index;
        if (index == 0) {
            self.sliderItemView.frame = CGRectMake(itemX, 0, itemWH, itemWH);
        }
        itemView.frame = CGRectMake(itemX, 0, itemWH, itemWH);
        [self.containerView addSubview:itemView];
    }
    [self.containerView addSubview:self.sliderItemView];
    [self.containerView bringSubviewToFront:self.sliderItemView];
}

#pragma mark - setters
- (void)setPageNumber:(NSInteger)pageNumber {
    _pageNumber = pageNumber;
    // 清空数据
    [self.itemDict removeAllObjects];
    for (UIView *itemView in self.containerView.subviews) {
        [itemView removeFromSuperview];
    }
    // 保存数据
    for (int index = 0; index < pageNumber; index++) {
        UIView *itemView = [[UIView alloc]init];
        itemView.layer.cornerRadius = itemWH/2;
        itemView.backgroundColor = self.normalColor == nil ? [UIColor lightGrayColor] : self.normalColor;
        [self.itemDict setObject:itemView forKey:[NSString stringWithFormat:@"%d",index]];
    }
    // 设置位置
    if (self.frame.size.width > 0) {
        [self p_setUpFrames];
    }
}

- (void)setIsNormalType:(BOOL)isNormalType {
    _isNormalType = isNormalType;
    [self p_setUpFrames];
}

- (void)setHighlightColor:(UIColor *)highlightColor {
    _highlightColor = highlightColor;
    self.sliderItemView.backgroundColor = highlightColor;
}

#pragma mark - getters
- (NSMutableDictionary *)itemDict {
    if (_itemDict == nil) {
        _itemDict = [NSMutableDictionary dictionary];
    }
    return _itemDict;
}

- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [[UIView alloc]init];
    }
    return _containerView;
}

- (UIView *)sliderItemView {
    if (_sliderItemView == nil) {
        _sliderItemView = [[UIView alloc]init];
        _sliderItemView.backgroundColor = [UIColor whiteColor];
        _sliderItemView.layer.cornerRadius = itemWH/2;
    }
    return _sliderItemView;
}
@end
