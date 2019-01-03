//
//  ThirdViewController.m
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "ThirdViewController.h"
#import "GXJButtonControl.h"

@interface ThirdViewController ()<CAAnimationDelegate,GXJButtonControlDelegate>
@property (strong, nonatomic) UIImageView *imageV;
@property (nonatomic,strong)GXJButtonControl *controlView;
@property (nonatomic,strong)NSArray *array;
@end

@implementation ThirdViewController
{
    GXJTextField *textF;
    XJTextView *textV;
}

- (NSArray *)array
{
    if(!_array)
    {
        _array = [NSArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    textF = [[GXJTextField alloc]initWithFrame:CGRectMake(20, 10, 200, 40)];
    textF.layer.borderWidth = 1;
    textF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textF.layer.cornerRadius = 4;
    textF.placeholder = @"请输入手机号";
    textF.font = 14;
    [self.view addSubview:textF];
    
    textV = [[XJTextView alloc]initWithFrame:CGRectMake(20, 60, 200, 80)];
    textV.placeholder = @"输入意见";
    textV.layer.borderWidth = 1;
    textV.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:textV];
    
    _array = @[@"安卓",@"iOS",@"微信"];
    
    _controlView = [[GXJButtonControl alloc]initWithArray:_array isBoder:YES defaultSelect:2 textFont:15 normalColor:APPCOLOR selectColor:[UIColor whiteColor]];
    _controlView.frame = CGRectMake(20, 150, 200, 40);
    _controlView.delegate = self;
    [self.view addSubview:_controlView];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:_array];
    seg.frame = CGRectMake(20, 200, 240, 30);
    seg.tintColor = [UIColor redColor];
    seg.selectedSegmentIndex = 0;
    [seg setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    [self.view addSubview:seg];
}

#pragma mark --- GXJButtonControlDelegate

- (void)buttonControl:(GXJButtonControl *)control didSelectSegmentAtIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
