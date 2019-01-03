//
//  GXJTextField.m
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.ll rights reserved.
//

#import "GXJTextField.h"

@interface GXJTextField()<UITextFieldDelegate>
@property (nonatomic,strong)UIImageView *pic;
@property (nonatomic,strong)UITextField *textF;
@end

@implementation GXJTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andImage:(NSString *)image {
    self = [super initWithFrame: frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _textF = [[UITextField alloc]initWithFrame:CGRectMake(10+_pic.frame.size.width, 0, self.frame.size.width-10-_pic.frame.size.width, self.frame.size.height)];
    _textF.delegate = self;
    [self addSubview:_textF];
}

- (void)setFont:(CGFloat)font {
    _font = font;
    _textF.font = [UIFont systemFontOfSize:_font];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _textF.placeholder = placeholder;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    _pic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, self.frame.size.height-10, self.frame.size.height-10)];
    _pic.image = [UIImage imageNamed:imageName];
    [self addSubview:_pic];
    
    _textF = [[UITextField alloc]initWithFrame:CGRectMake(15+_pic.frame.size.width, 0, self.frame.size.width-10-_pic.frame.size.width, self.frame.size.height)];
    _textF.delegate = self;
    [self addSubview:_textF];
}

- (void)setClear:(BOOL)clear {
    _clear = clear;
    if (clear)
        _textF.clearButtonMode = UITextFieldViewModeWhileEditing;
    else
        _textF.clearButtonMode = UITextFieldViewModeNever;
}

- (void)setCorcornerRadius:(CGFloat)corcornerRadius {
    self.layer.cornerRadius = corcornerRadius;
}

- (void)setText:(NSString *)text {
    _textF.text = text;
}

- (NSString *)text {
    return _textF.text;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
}

- (void)setIsResponse:(BOOL)isResponse {
    _isResponse = isResponse;
    if (!_isResponse) {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
        [firstResponder resignFirstResponder];
    }
}
@end
