//
//  GXJTextField.h
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GXJTextField : UIView
- (instancetype)initWithFrame:(CGRect)frame andImage:(NSString *)image;

@property (nonatomic,assign)CGFloat cornerRadius;
@property (nonatomic,copy)NSString *imageName;
@property (nonatomic,copy)NSString *placeholder;
@property (nonatomic,assign)BOOL clear;
@property (nonatomic,assign)CGFloat font;
@property (nonatomic,assign)BOOL isResponse;
@property(nonatomic,copy)NSString *text;
@end
