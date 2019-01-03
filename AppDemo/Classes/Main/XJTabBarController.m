//
//  XJTabBarController.m
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "XJTabBarController.h"

#import "XJNavigationController.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface XJTabBarController ()
@property(nonatomic,assign)NSInteger lastNo;
@end

@implementation XJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lastNo = 0;

    [self setupAllChildViewControllers];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    self.lastNo = [tabBar.items indexOfObject:item];
    NSLog(@"%ld",self.lastNo);
}

- (void)setupAllChildViewControllers {
    
    FirstViewController *first = [[FirstViewController alloc] init];
    [self setupChildController:first title:@"常用框架" tabbarTitle:@"常用框架" imageName:@"首页" selectImageName:@"首页A"];
    
    SecondViewController *second = [[SecondViewController alloc] init];
    [self setupChildController:second title:@"轮播图" tabbarTitle:@"轮播图" imageName:@"便民" selectImageName:@"便民A"];
    
    ThirdViewController *first1 = [[ThirdViewController alloc] init];
    [self setupChildController:first1 title:@"常用控件" tabbarTitle:@"常用控件" imageName:@"办事" selectImageName:@"办事A"];
    
}

- (void)setupChildController:(UIViewController *)controller title:(NSString *)title tabbarTitle:(NSString *)tabbarTitle imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName {
    
    controller.title = title;
    controller.tabBarItem.title = tabbarTitle;
    
    [controller.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:APPCOLOR} forState:UIControlStateSelected];
    
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectImageName];
    controller.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    XJNavigationController *navigationController = [[XJNavigationController alloc] initWithRootViewController:controller];
    navigationController.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:navigationController];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
