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
#import "ZMProgressViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FirstViewController
{
    UITableView *table;
    NSArray *array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    array = @[@"ScrollPages(仿今日头条)",@"弹框",@"选择按钮和多个按钮自动换行",@"悬浮按钮",@"进度条",@"仿芝麻信用"];

    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT)];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellsign = @"tablecell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = array[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController pushViewController:[CityRecorderController new] animated:YES];
        }
            break;
            
        case 1:
        {
            [self.navigationController pushViewController:[PopWindowController new] animated:YES];
        }
            break;
            
        case 2:
        {
            [self.navigationController pushViewController:[ButtonControlTest new] animated:YES];
        }
            break;
            
        case 3:
        {
            [self.navigationController pushViewController:[FloatButtonTest new] animated:YES];
        }
            break;
            
        case 4:
        {
            [self.navigationController pushViewController:[ProgressTest new] animated:YES];
        }
            break;
            
        case 5:
        {
            [self.navigationController pushViewController:[ZMProgressViewController new] animated:YES];
        }
            break;
            
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
