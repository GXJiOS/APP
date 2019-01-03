//
//  CityRecorderController.m
//  AppFrame
//
//  Created by GXJ on 2017/3/6.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "CityRecorderController.h"
#import "CityRecorderInfoController.h"
#import "GXJPagesViewController.h"

@interface CityRecorderController ()

@end

@implementation CityRecorderController
{
    NSArray *array;
    GXJPagesViewController *control;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"都市报道";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //要添加的子视图
    NSMutableArray *viewArr = [[NSMutableArray alloc]init];
    array = @[@"推荐",@"都市",@"都市都市都市都市",@"推荐",@"都市",@"推荐",@"都市"];
    //array = @[@"推荐",@"英雄联盟"];
    //array = @[@"推荐",@"英雄联盟",@"炉石传说",@"英雄",@"游戏天地",@"情感",@"推荐",@"英雄联盟",@"炉石传说",@"英雄",@"游戏天地",@"情感"];
    
    for (int i = 0 ; i<array.count; i++) {
        CityRecorderInfoController *vc = [CityRecorderInfoController new];
        vc.title = array[i];//必选
        vc.indexNum = i;
        [viewArr addObject:vc];
    }
    
    NSInteger onepageNumber;
    if(array.count < 5){
        onepageNumber = array.count;
    }
    else{
        onepageNumber = 5;
    }
    
    int i = 4;
    
    switch (i) {
        case 1:
        {
            /*数组过少时不使用*/
            control = [[GXJPagesViewController alloc]initWithLabelMargin:20 titleArray:viewArr normalColor:[UIColor grayColor] selectColor:APPCOLOR normalfont:13 selectfont:15 frame:CGRectMake(20, 100,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        }
            break;
            
        case 2:
        {
            /*标题文字过长时不使用*/
            control = [[GXJPagesViewController alloc]initWithTitleLengthType:STATICLENGTH onepageNumber:onepageNumber titleArray:viewArr normalColor:[UIColor grayColor] selectColor:APPCOLOR normalfont:13 selectfont:16 frame:CGRectMake(20, 100,[UIScreen mainScreen].bounds.size.width -100, 300)];
        }
            break;
            
        case 3:
        {
            /*标题文字过长时不使用*/
            control = [[GXJPagesViewController alloc]initWithTitleLengthType:AUTOTOTEXT onepageNumber:onepageNumber titleArray:viewArr normalColor:[UIColor grayColor] selectColor:APPCOLOR normalfont:13 selectfont:16 frame:CGRectMake(20, 100,[UIScreen mainScreen].bounds.size.width -100, 300)];
        }
            break;
            
        case 4:
        {
            /*常用*/
            control = [[GXJPagesViewController alloc]initWithTitleLengthType:AUTOLENGTHSTATICNUM onepageNumber:onepageNumber titleArray:viewArr normalColor:[UIColor grayColor] selectColor:APPCOLOR normalfont:13 selectfont:16 frame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, kSCREENHEIGHT-64)];
        }
            break;
            
        default:
            break;
    }

    control.canBounces = YES;//标题是否回弹
    control.lineColor = [UIColor lightGrayColor];//线条颜色
    
    [self addChildViewController:control];
    [self.view addSubview:control.view];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)fun {
    control.array = @[@"111",@"222"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
