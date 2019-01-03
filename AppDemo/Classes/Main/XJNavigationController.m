//
//  XJNavigationController.m
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "XJNavigationController.h"

@interface XJNavigationController ()

@end

@implementation XJNavigationController

+ (void)initialize {
//    [self setupBackStyle];
    [self setupNavigationBarStyle];
    [self setupNavigationItemStyle];
}


+ (void)setupNavigationBarStyle {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBackgroundColor:APPCOLOR];//
    [navigationBar setBarTintColor:APPCOLOR];
    navigationBar.translucent = NO;
    
    NSMutableDictionary *attributeDict = [NSMutableDictionary dictionary];
    attributeDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attributeDict[NSFontAttributeName] = [UIFont fontWithName:HEITIMEDIUM size:18];
    [navigationBar setTitleTextAttributes:attributeDict];
}

+ (void)setupNavigationItemStyle {
    UIBarButtonItem *navigationItem = [UIBarButtonItem appearance];
    
    NSMutableDictionary *attributeDict = [NSMutableDictionary dictionary];
    attributeDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attributeDict[NSFontAttributeName] = [UIFont fontWithName:HEITILIGHT size:16];
    [navigationItem setTitleTextAttributes:attributeDict forState:UIControlStateNormal];
    
    NSMutableDictionary *disableAttributeDict = [NSMutableDictionary dictionary];
    disableAttributeDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableAttributeDict[NSFontAttributeName] = [UIFont fontWithName:HEITILIGHT size:16];
    [navigationItem setTitleTextAttributes:disableAttributeDict forState:UIControlStateDisabled];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.view.backgroundColor = [UIColor whiteColor];
    }
    [super pushViewController:viewController animated:animated];
    
//    if (self.viewControllers.count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//        if (animated) {
//
//            CATransition *animation = [CATransition animation];
//            animation.duration = 0.4f;
//            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//            animation.type = kCATransitionPush;
//            animation.subtype = kCATransitionFromRight;
//            [self.navigationController.view.layer addAnimation:animation forKey:nil];
//            [self.view.layer addAnimation:animation forKey:nil];
//            [super pushViewController:viewController animated:NO];
//            return;
//        }
//    }
//    [super pushViewController:viewController animated:animated];
}


@end
