//
//  CityRecorderInfoController.m
//  AppFrame
//
//  Created by GXJ on 2017/3/6.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "CityRecorderInfoController.h"

@interface CityRecorderInfoController ()

@end

@implementation CityRecorderInfoController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    NSLog(@"%f==%f",self.view.frame.size.width,self.view.frame.size.height);
    label.center = self.view.center;
    label.text = @(_indexNum).stringValue;
    [self.view addSubview:label];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
