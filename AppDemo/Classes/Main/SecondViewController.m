//
//  SecondViewController.m
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "SecondViewController.h"
#import "TLNewsView.h"
#import "SDCycleScrollView.h"
#import "VerticalAdScrollView.h"

@interface SecondViewController ()<TLCycleScrollViewDelegate,SDCycleScrollViewDelegate,VerticalAdScrollDataSource,VerticalAdScrollDelegate>
@property (nonatomic,strong)NSArray *verArray;
@end

@implementation SecondViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = @[@"http://www.5577.com/up/2014-8/14074003983030240.jpg",
                     @"http://fujian.86516.com/forum/201209/28/16042484m9y9izwbrwuixj.jpg"];
    
    SDCycleScrollView *adScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    adScrollView.currentPageDotColor = [UIColor blackColor];
    adScrollView.pageDotColor = [UIColor whiteColor];
    adScrollView.imageURLStringsGroup = arr;
    [self.view addSubview:adScrollView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *arr1 = @[@"11",
                     @"22"];
    
    TLNewsView *tlScrollView = [[TLNewsView alloc]initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, 50)];
    tlScrollView.titlesGroup = arr1;
    tlScrollView.delegate = self;
    [self.view addSubview:tlScrollView];
    
    _verArray = @[@{@"title":@"1"},@{@"title":@"2"},@{@"title":@"3"}];
    
    VerticalAdScrollView *verticalView = [[VerticalAdScrollView alloc]initWithFrame:CGRectMake(0, 290, self.view.frame.size.width, 80)];
    
    verticalView.backgroundColor = [UIColor whiteColor];
    verticalView.dataSource = self;
    verticalView.delegate = self;
    verticalView.minimumPageAlpha = 0.4;
    //verticalView.minimumPageScale = 1.0;
    verticalView.autoTime = 3.0f;
    verticalView.orginPageCount = _verArray.count;
    verticalView.isOpenAutoScroll = YES;
    [verticalView reloadData];
    
    [self.view addSubview:verticalView];
}

#pragma mark --- SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    
}

#pragma mark --- TLCycleScrollViewDelegate

- (void)tlcycleScrollView:(TLNewsView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //NSLog(@"%ld",index);
}

- (void)tlcycleScrollView:(TLNewsView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    //NSLog(@"%ld",index);
}

#pragma mark - VerticalAdScrollDelegate
- (CGSize)sizeForVerticalPageInFlowView:(VerticalAdScrollView *)flowView {
    return CGSizeMake(self.view.frame.size.width, 80);
}

- (void)didSelectVerticalCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    if (subIndex > _verArray.count - 1) {
        return;
    }
    NSDictionary *dic = _verArray[subIndex];
    NSString *urlString = dic[@"url"];
    NSString *titleString = dic[@"contentTitle"];
    //[self clickWithURL:urlString title:titleString State:nil];
    NSLog(@"%ld",subIndex);
}

#pragma mark - VerticalAdScrollDataSource
- (NSInteger)numberOfVerticalPagesInFlowView:(VerticalAdScrollView *)flowView {
    return _verArray.count;
}

- (UIView *)flowView:(VerticalAdScrollView *)flowView cellForVerticalPageAtIndex:(NSInteger)index{
    
    VerticalView *superView = (VerticalView *)[flowView dequeueReusableCell];
    if (!superView) {
        superView = [[VerticalView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
        
    }
    NSDictionary *dataDic = _verArray[index];
    superView.superDataDic = dataDic;
    superView.index = index;
    
    return superView;
}

#pragma mark - VerticalViewDelegate
- (void)clickVerticalViewWithIndex:(NSInteger)index {
    
    NSLog(@"%ld",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
