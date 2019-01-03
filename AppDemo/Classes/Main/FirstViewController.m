//
//  FirstViewController.m
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "FirstViewController.h"
#import "GXJTextField.h"
#import "XJTextView.h"
#import "CityRecorderController.h"
#import "PopWindowController.h"
#import "ButtonControlTest.h"
#import "FloatButtonTest.h"
#import "ProgressTest.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellsign = @"tablecell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.dataArray[indexPath.row]objectForKey:@"title"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Class controller = NSClassFromString([self.dataArray[indexPath.row]objectForKey:@"controller"]);
    [self.navigationController pushViewController:[[controller alloc]init] animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- getters
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @{
                           @"title":@"ScrollPages(仿今日头条)",
                           @"controller":@"CityRecorderController"
                           },
                       @{
                           @"title":@"弹框",
                           @"controller":@"PopWindowController"
                           },
                       @{
                           @"title":@"选择按钮和多个按钮自动换行",
                           @"controller":@"ButtonControlTest"
                           },
                       @{
                           @"title":@"悬浮按钮",
                           @"controller":@"FloatButtonTest"
                           },
                       @{
                           @"title":@"进度条",
                           @"controller":@"ProgressTest"
                           },
                       ];
    }
    return _dataArray;
}


@end
