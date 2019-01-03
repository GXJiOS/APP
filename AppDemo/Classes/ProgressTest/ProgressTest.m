//
//  ProgressTest.m
//  AppFrame
//
//  Created by GXJ on 2017/4/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "ProgressTest.h"
#import "HWWaveView.h"
#import "HWCircleView.h"
#import "HWProgressView.h"
#import "HWInstallView.h"

#import "XJProgressView.h"

@interface ProgressTest ()
@property (nonatomic, weak) XJProgressView *progressView;

@end

@implementation ProgressTest

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setUpView];
    //添加定时器
}

- (void)setUpView {
    
//    //波浪
//    HWWaveView *waveView = [[HWWaveView alloc] initWithFrame:CGRectMake(30, 100, 150, 150)];
//    [self.view addSubview:waveView];
//    self.waveView = waveView;
//    
//    //圆圈
//    HWCircleView *circleView = [[HWCircleView alloc] initWithFrame:CGRectMake(220, 100, 150, 150)];
//    [self.view addSubview:circleView];
//    self.circleView = circleView;
//    
//    //进度条
//    HWProgressView *progressView = [[HWProgressView alloc] initWithFrame:CGRectMake(30, 365, 150, 20)];
//    [self.view addSubview:progressView];
//    self.progressView = progressView;
//    
//    //加载安装效果
//    HWInstallView *installView = [[HWInstallView alloc] initWithFrame:CGRectMake(220, 300, 150, 150)];
//    [self.view addSubview:installView];
//    self.installView = installView;
    
    XJProgressView *circleView = [[XJProgressView alloc] initWithFrame:CGRectMake(10, 10, 150, 150)];
    circleView.progressType = CIRCLEPROGRESS;
    circleView.progress = 0.8;
    circleView.strokeColor = [UIColor redColor];
    circleView.strokeWidth = 5.0f;
    circleView.finishTime = 2.0;
    [self.view addSubview:circleView];
    self.progressView = circleView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
