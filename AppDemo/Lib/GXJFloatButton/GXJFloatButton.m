//
//  GXJFloatButton.m
//  AppFrame
//
//  Created by GXJ on 2017/3/29.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "GXJFloatButton.h"

@implementation GXJFloatButton
{
    float _nLogoWidth;//浮标的宽度
    float _nLogoHeight;//浮标的高度
    float _nLogoCenterX;//浮标的中心X
    float _nLogoCenterY;//浮标的中心Y
    float _nLogoPadding;//浮标距离两边边距
}

- (void)setImageName:(NSString *)imageName {
    
    _imageName = imageName;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _nLogoWidth, _nLogoHeight)];
    imageview.image = [UIImage imageNamed:_imageName];
    imageview.layer.cornerRadius = _nLogoWidth / 2;
    imageview.layer.masksToBounds = YES;
    [self addSubview:imageview];
}

- (void)setIsShadow:(BOOL)isShadow {
    
    if (isShadow) {
        self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        self.layer.shadowOffset = CGSizeMake(0,0);
        self.layer.shadowOpacity = 0.2;//阴影透明度，默认0
        self.layer.shadowRadius = 4;//阴影半径，默认3
    }
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        _nLogoWidth = frame.size.width;
        _nLogoHeight = frame.size.height;
        _nLogoCenterX = self.center.x;
        _nLogoCenterY = self.center.y;
        
        if (_nLogoCenterX >= SCREEN_WIDTH / 2) {
            _nLogoPadding = SCREEN_WIDTH - _nLogoCenterX - _nLogoWidth / 2;
        }
        else {
            _nLogoPadding = frame.origin.x;
        }
        
        self.isMoving = YES;
        self.isShadow = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = frame.size.width / 2;
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = YES;
        self.alpha = 0.8f;
        
        UITapGestureRecognizer *publishTap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        publishTap.delegate = self;
        [self addGestureRecognizer:publishTap];
    }
    return self;
}

- (void)tapAction {
    
    self.block();
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

//开始移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_isMoving) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint movedPT = [touch locationInView:[self superview]];
    
    _nLogoCenterX = movedPT.x;
    _nLogoCenterY = movedPT.y;
    
    [self setCenter:movedPT];
}

//移动结束
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_isMoving) {
        return;
    }
    
    [self calculateLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_isMoving) {
        return;
    }
    
    [self calculateLocation];
}

//计算四个位置
- (void)calculateLocation {
    
    LocationTag nowLocationTag;
    if (_nLogoCenterY <= SCREEN_HEIGHT / 2) {//上半部分
        
        if (_nLogoCenterX <= SCREEN_WIDTH / 2 ) {//左半部分
            
            if (_nLogoCenterY < _nLogoCenterX) {
                nowLocationTag = kLocationTag_top;
            }
            else {
                nowLocationTag = kLocationTag_left;
            }
        }
        else {//右半部分
            if (_nLogoCenterY < SCREEN_WIDTH - _nLogoCenterX) {
                nowLocationTag = kLocationTag_top;
            }
            else {
                nowLocationTag = kLocationTag_right;
            }
        }
    }
    else {//下半部分
        
        if (_nLogoCenterX <= SCREEN_WIDTH / 2 ) {//左半部分
            
            if (SCREEN_HEIGHT - _nLogoCenterY < _nLogoCenterX) {
                nowLocationTag = kLocationTag_bottom;
            }
            else {
                nowLocationTag = kLocationTag_left;
            }
        }
        else {//右半部分
            if (SCREEN_HEIGHT - _nLogoCenterY < SCREEN_WIDTH - _nLogoCenterX) {
                nowLocationTag = kLocationTag_bottom;
            }
            else {
                nowLocationTag = kLocationTag_right;
            }
        }
    }
    [self computeOfLocation:nowLocationTag];
}

//完成移动
- (void)computeOfLocation:(LocationTag )locationTag {
    
    switch (locationTag) {
        case kLocationTag_top: {
            [UIView animateWithDuration:0.2 animations:^{
                self.center = CGPointMake(_nLogoCenterX, _nLogoHeight /2  + _nLogoPadding);
            }];
        }
            break;
            
        case kLocationTag_left: {
            [UIView animateWithDuration:0.2 animations:^{
                self.center = CGPointMake(_nLogoWidth / 2 + _nLogoPadding, _nLogoCenterY);
            }];
        }
            break;

        case kLocationTag_bottom: {
            [UIView animateWithDuration:0.2 animations:^{
                self.center = CGPointMake(_nLogoCenterX, SCREEN_HEIGHT - _nLogoHeight / 2 - _nLogoPadding);
            }];
        }
            break;

        case kLocationTag_right: {
            [UIView animateWithDuration:0.2 animations:^{
                self.center = CGPointMake(SCREEN_WIDTH - _nLogoWidth / 2 - _nLogoPadding, _nLogoCenterY);
            }];
        }
            break;
            
        default:
            break;
    }
    
}

@end
