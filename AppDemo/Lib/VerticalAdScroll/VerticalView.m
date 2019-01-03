//
//  VerticalView.m
//  zjGovernment
//
//  Created by GXJ on 2017/5/10.
//  Copyright © 2017年 胡胜冬. All rights reserved.
//

#import "VerticalView.h"

@interface VerticalView()
@property (nonatomic,strong)UILabel *label;
@end

@implementation VerticalView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self createView];

    }
    return self;
}

- (void)createView {
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _label.font = [UIFont systemFontOfSize:15];
    _label.textAlignment = 1;
    _label.userInteractionEnabled = YES;
    [self addSubview:_label];
}

#pragma mark - set 方法
- (void)setCustomAlpha:(CGFloat)customAlpha {
    _customAlpha = customAlpha;
    self.layer.shadowOpacity = customAlpha;
}

- (void)setSuperDataDic:(NSDictionary *)superDataDic {
    
    _superDataDic = superDataDic;
    _label.text = _superDataDic[@"title"];
}

@end
