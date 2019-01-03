//
//  ButtonControlTest.m
//  AppFrame
//
//  Created by GXJ on 2017/3/29.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "ButtonControlTest.h"

#import "HistoryButtonGroup.h"

@interface ButtonControlTest ()<HistoryButtonGroupClearDelegate>

@end

@implementation ButtonControlTest
{
    HistoryButtonGroup *history;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择按钮";
    
    [self setUpView];
}

#pragma mark --- 绘制页面

- (void)setUpView {
    
    NSArray *tarr = @[@"盗墓笔记",@"空空道人谈股市",@"叶文有话要说",@"相声",@"二货一箩筐",@"单田方",@"城市",@"美女",@"社交恐惧",@"家庭矛盾",@"失恋",@"局势很简单",@"Word",@"美女",@"体育",@"美女与野兽",@"生化危机"];
    
    history = [[HistoryButtonGroup alloc]initWithTitle:@"最近搜索" buttonGroup:tarr originalX:10 originalY:10 buttonHM:10 buttonVM:10 buttonHeight:30 textFont:13];
    
    history.delegate = self;
    
    history.block = ^(NSString *title){
        NSLog(@"%@",title);
    };
    
    history.imageName = @"关闭";

    [self.view addSubview:history];
    
    HistoryButtonGroup *history1 = [[HistoryButtonGroup alloc]initWithTitle:@"热搜" buttonGroup:tarr originalX:10 originalY:CGRectGetMaxY(history.frame)+20 buttonHM:10 buttonVM:10 buttonHeight:30 textFont:13];
    
    history1.block = ^(NSString *title){
        NSLog(@"%@",title);
    };

    [self.view addSubview:history1];
    
}

#pragma mark --- HistoryButtonGroupClearDelegate
- (void)rigthAction {
    for (UIButton *btn in history.subviews) {
        
        if([btn isKindOfClass:[UIButton class]])
            [btn removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
