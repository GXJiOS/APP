//
//  ForthViewController.m
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "ForthViewController.h"

@interface ForthViewController ()
@property (nonatomic,strong)NSMutableArray *array;
@end

@implementation ForthViewController

- (NSMutableArray *)array
{
    if(!_array)
    {
        _array = [NSMutableArray array];
    }
    return _array;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *topView = UIView.new;
    topView.backgroundColor = UIColor.greenColor;
    topView.layer.borderColor = UIColor.blackColor.CGColor;
    topView.layer.borderWidth = 2;
    [self.view addSubview:topView];
    
    UIView *topSubview = UIView.new;
    topSubview.backgroundColor = UIColor.blueColor;
    topSubview.layer.borderColor = UIColor.blackColor.CGColor;
    topSubview.layer.borderWidth = 2;
    [topView addSubview:topSubview];
    
    UIView *bottomView = UIView.new;
    bottomView.backgroundColor = UIColor.redColor;
    bottomView.layer.borderColor = UIColor.blackColor.CGColor;
    bottomView.layer.borderWidth = 2;
    [self.view addSubview:bottomView];
    
    [topView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(40);
    }];
    
    [topSubview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).with.offset(@10);
        make.centerX.equalTo(@0);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view1];
    
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_top);
        make.width.equalTo(self.view);
        make.height.equalTo(@50);
        
    }];
    
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor lightGrayColor];
    label.numberOfLines = 0;
    label.text = @"diuhfufhuehfuefhufhguipfhvuiefhguifehvuigw";
    [self.view addSubview:label];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(@20);
        make.right.equalTo(self.view).with.offset(@-30);
        make.height.equalTo(kSCREENHEIGHT/4);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
