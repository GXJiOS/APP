//
//  SecondViewController.m
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "SecondViewController.h"
#import "DTCycleView.h"
#import "VerticalBannerTest.h"

@interface SecondViewController ()<DTCyleViewCustomViewDelegate>
@property (nonatomic,strong) DTCycleView *bannerView;

@end

@implementation SecondViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(150);
    }];
    
    
    NSArray *imageArray = @[@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1544429969&di=d9b684a197292e62062cf53961d8494a&src=http://baiducdn.pig66.com/uploadfile/2017/0511/20170511074826936.jpg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544440037808&di=e4351a561f31ee6423f6b221390b573d&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F908fa0ec08fa513d76978e43376d55fbb2fbd96a.jpg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544508798379&di=76c108dff7b368f91cd4d2f4684aa27b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201505%2F09%2F20150509210330_zBGyA.jpeg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544515425676&di=af6cfcbb502636b284992614088cb088&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201512%2F15%2F20151215223211_h5QHv.thumb.700_0.jpeg"
                            ];
    self.bannerView.netImageUrlStringArray = imageArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - delegates
// -----------------------轮播点击的代理方法-----------------------
- (void)DTCycleViewClickIndex:(NSInteger)index {
    [self.navigationController pushViewController:[[VerticalBannerTest alloc]init] animated:YES];
}

#pragma mark - getters
- (DTCycleView *)bannerView {
    if (_bannerView == nil) {
        _bannerView = [[DTCycleView alloc]initWithRuseKey:@"homeBanner"];
        _bannerView.repeatTime = 3;
        _bannerView.delegate = self;
        _bannerView.scrollType = DTCycleViewScrollTypeParallex;
    }
    return _bannerView;
}

@end
