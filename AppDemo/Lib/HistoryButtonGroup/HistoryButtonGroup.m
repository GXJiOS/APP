//
//  HistoryButtonGroup.m
//  AppFrame
//
//  Created by GXJ on 2017/3/30.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "HistoryButtonGroup.h"

@interface HistoryButtonGroup()

@property (nonatomic,copy)   NSString *title;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,assign) float originalX;
@property (nonatomic,assign) float originalY;
@property (nonatomic,assign) float buttonHM;
@property (nonatomic,assign) float buttonVM;
@property (nonatomic,assign) float buttonHeight;
@property (nonatomic,assign) float textFont;

@end

@implementation HistoryButtonGroup

- (instancetype)initWithTitle:(NSString *)title buttonGroup:(NSArray *)array originalX:(float)originalX originalY:(float)originalY buttonHM:(float)buttonHM buttonVM:(float)buttonVM buttonHeight:(float)buttonHeight textFont:(float)textFont {
    self = [super init];
    if (self) {
        
        _title = title;
        _array = array;
        _originalX = originalX;
        _originalY = originalY;
        _buttonHM = buttonHM;
        _buttonVM = buttonVM;
        _buttonHeight = buttonHeight;
        _textFont = textFont;
        _textColor = [UIColor darkTextColor];
        _boderColor = [UIColor lightGrayColor];
        
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    float butX = _originalX;
    float butY = 0;
    
    if (_title && ![_title isEqualToString:@""]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(butX, butY, 200, 15)];
        label.text = _title;
        label.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:label];
        
        butY = 15 + _buttonVM;
    }

    for (int i = 0; i < _array.count; i++) {

        //宽度自适应
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:_textFont]};
        CGRect frame_W = [_array[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];

        if (butX+frame_W.size.width + 20 > [[UIScreen mainScreen] bounds].size.width - _originalX) {

            butX = _originalX;

            butY += _buttonVM + _buttonHeight;
        }

        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width + 20, _buttonHeight)];
        [but setTitle:_array[i] forState:UIControlStateNormal];
        [but setTitleColor:_textColor forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:_textFont];
        but.layer.cornerRadius = 6;
        but.layer.borderColor = _boderColor.CGColor;
        but.layer.borderWidth = 1;
        [but addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but];
        
        butX = CGRectGetMaxX(but.frame)+_buttonHM;
    }
    
    self.frame = CGRectMake(0,_originalY , [[UIScreen mainScreen] bounds].size.width, butY+_buttonHeight);
}

#pragma mark --- 点击按钮

- (void)buttonClick:(UIButton *)sender {
    self.block(sender.titleLabel.text);
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    for (UIButton *btn in self.subviews) {
        [btn setTitleColor:_textColor forState:UIControlStateNormal];
    }
}

- (void)setBoderColor:(UIColor *)boderColor {
    _boderColor = boderColor;
    for (UIButton *btn in self.subviews) {
        btn.layer.borderColor = _boderColor.CGColor;
    }
}

- (void)setBackColor:(UIColor *)backColor {
    _backColor = backColor;
    for (UIButton *btn in self.subviews) {
        btn.backgroundColor = _backColor;
        btn.layer.borderWidth = 0;
    }
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-15-_originalX, 0, 15, 15)];
    imageView.image = [UIImage imageNamed:_imageName];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightAction)];
    [imageView addGestureRecognizer:recognizer];
    [self addSubview:imageView];
}

#pragma mark --- 右按钮动作

- (void)rightAction {
    [self.delegate rigthAction];
}

@end
