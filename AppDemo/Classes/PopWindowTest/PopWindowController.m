//
//  PopWindowController.m
//  AppFrame
//
//  Created by GXJ on 2017/3/7.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "PopWindowController.h"
#import "GXJPopTool.h"
#import "XJActionSheet.h"
#import "XJNavigationMenuView.h"

@interface PopWindowController ()<GXJPopToolDelegate,XJActionSheetDelegate>
@property (nonatomic,strong)UIView *contentView;

@property (nonatomic,strong)XJNavigationMenuView *menuView;
@end

@implementation PopWindowController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"弹框";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 100, 40)];
    [btn1 setTitle:@"中部弹框" forState:0];
    [btn1 setTitleColor:[UIColor blackColor] forState:0];
    [btn1 addTarget:self action:@selector(popCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(130, 20,100, 40)];
    [btn2 setTitle:@"底部弹框" forState:0];
    [btn2 setTitleColor:[UIColor blackColor] forState:0];
    [btn2 addTarget:self action:@selector(popBottom) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
      
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(20, 100,100, 40)];
    [btn3 setTitle:@"下拉列表" forState:0];
    [btn3 setTitleColor:[UIColor blackColor] forState:0];
    [btn3 addTarget:self action:@selector(popMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
}
/*中部弹框*/
-(void)popCenter
{
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH*3/5, kSCREENWIDTH*3/5*1.2+30)];
    _contentView.backgroundColor = [UIColor grayColor];
    
    [GXJPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
    [GXJPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
    [GXJPopTool sharedInstance].popBackgroudColor = [UIColor redColor];
    [GXJPopTool sharedInstance].delegate = self;
    GXJPopToolInstance.closeAnimated = YES;
    [[GXJPopTool sharedInstance] showWithPresentView:_contentView animated:YES];
}

/*关闭中部弹框*/
-(void)closeAction
{
    
}
/*底部弹框*/
-(void)popBottom
{
    XJActionSheet *popView = [[XJActionSheet alloc]initWithTitle:@[@"1",@"2",@"3"] image:@[@"我的"] showLineNumber:5 andScroll:YES];
    popView.delegate = self;
}

-(void)sheetViewDidSelectIndex:(NSInteger)index title:(NSString *)title
{
    NSLog(@"%ld,%@",index,title);
}
-(void)popMenu:(UIButton *)sender
{
    if (_menuView.isShow) {
        [_menuView disMissSelf];
        _menuView = nil;
        return;
    }
    NSArray *imageArray = @[@"share",@"star",@"share"];
    NSArray *titleArray = @[@"扫一扫",@"加好友",@"创建讨论组"];
    
    _menuView = [[XJNavigationMenuView alloc] initWithPositionOfDirection:CGPointMake(sender.center.x, CGRectGetMaxY(sender.frame)) images:imageArray titleArray:titleArray backColor:[UIColor colorWithHexString:@"000000"] titleColor:[UIColor colorWithHexString:@"ffffff"]];
    
    _menuView.clickedBlock = ^(NSInteger index) {
    };
    [self.view addSubview:_menuView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
