//
//  TLCollectionViewCell.m
//  AppFrame
//
//  Created by GXJ on 2017/3/14.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "TLCollectionViewCell.h"

@implementation TLCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    
    return self;
}

-(void)setupView
{
    _label = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, 40,20)];
    _label.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_label];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

}


@end
