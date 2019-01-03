//
//  FloatButtonTest.m
//  AppFrame
//
//  Created by GXJ on 2017/3/29.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "FloatButtonTest.h"
#import "GXJFloatButton.h"

@interface FloatButtonTest ()

@end

@implementation FloatButtonTest

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"悬浮按钮";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, (self.view.bounds.size.height-64)/2, SCREEN_WIDTH, 1)];
    line.backgroundColor = ColorString(@"000000");
    [self.view addSubview:line];
    
    GXJFloatButton * floatBtn = [[GXJFloatButton alloc]initWithFrame:CGRectMake(kSCREENWIDTH - 5 -50, kSCREENWIDTH-176, 50, 50)];
    
    floatBtn.imageName = @"办事";
    floatBtn.isShadow = YES;
    
    floatBtn.block = ^(){
        NSLog(@"点击");
    };
    [self.view addSubview:floatBtn];
    [self.view bringSubviewToFront:floatBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
