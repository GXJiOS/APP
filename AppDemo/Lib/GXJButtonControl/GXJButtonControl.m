//
//  GXJButtonControl.m
//  AppFrame
//
//  Created by GXJ on 2017/3/29.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "GXJButtonControl.h"

#define BODERWIDTH 1
#define CORNERRADIUS 5

@interface GXJButtonControl()
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,assign)BOOL isBoder;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,assign)CGFloat textFont;
@property (nonatomic,assign)UIColor *normalColor;
@property (nonatomic,assign)UIColor *selectColor;
@end

@implementation GXJButtonControl

- (NSArray *)array {
    if(!_array){
        _array = [NSArray array];
    }
    return _array;
}

- (instancetype)initWithArray:(NSArray *)array isBoder:(BOOL)isBoder defaultSelect:(NSInteger)defaultSelect textFont:(CGFloat)textFont normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor {
    self = [super init];
    if(self){
        _array = array;
        _isBoder = isBoder;
        _index = defaultSelect;
        _textFont = textFont;
        _normalColor = normalColor;
        _selectColor = selectColor;
        
        if (_isBoder) {
            self.layer.borderWidth = BODERWIDTH;
            self.layer.borderColor = _normalColor.CGColor;
            self.layer.cornerRadius = CORNERRADIUS;
            self.backgroundColor = _normalColor;
            
        }
        
        [self setupItems];
    }
    return self;
}

- (void)setupItems {
    for (NSInteger i = 0;i < _array.count;i++) {
        [self createItemWithTitle:_array[i] tag:i+1];
    }
}

- (void)createItemWithTitle:(NSString *)title tag:(NSInteger)tag {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:_normalColor forState:UIControlStateNormal];
    [button setTitleColor:_selectColor forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:_textFont];
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    
    if (tag == _index) {
        button.selected = YES;
        if(_isBoder){
            button.backgroundColor = _normalColor;
        }
    }
    [self addSubview:button];
    
}

- (void)buttonPressed:(UIButton *)sender {
    for (UIButton *btn in self.subviews) {
        if (btn.tag == _index) {
            btn.selected = NO;
            
            if (_isBoder) {
                btn.backgroundColor = [UIColor whiteColor];
            }
        }
    }
    _index = sender.tag;
    sender.selected = YES;
    if (_isBoder) {
        sender.backgroundColor = _normalColor;
    }
    
    if ([self.delegate respondsToSelector:@selector(buttonControl:didSelectSegmentAtIndex:)]) {
        [self.delegate buttonControl:self didSelectSegmentAtIndex:sender.tag ];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width;
    
    if (!_isBoder) {
        width = self.frame.size.width / _array.count;
    }
    else {
        width = (self.frame.size.width-_array.count * BODERWIDTH + BODERWIDTH) / _array.count;
    }
    
    for (NSUInteger i = 0; i < self.subviews.count; i ++) {
        UIButton *button = self.subviews[i];
        
        if (!_isBoder) {
            button.frame = CGRectMake(i * width, 0, width, self.frame.size.height);
        }
        else {
            button.frame = CGRectMake(i * (width+BODERWIDTH), 0, width, self.frame.size.height);
            
            if (i == 0) {
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(CORNERRADIUS, CORNERRADIUS)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame = button.bounds;
                maskLayer.path = maskPath.CGPath;
                button.layer.mask = maskLayer;
            }
            if (i == self.subviews.count-1) {
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(CORNERRADIUS,CORNERRADIUS)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame = button.bounds;
                maskLayer.path = maskPath.CGPath;
                button.layer.mask = maskLayer;
            }
        }
    }
}

@end
