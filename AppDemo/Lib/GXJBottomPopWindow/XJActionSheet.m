//
//  XJActionSheet.m
//  弹窗练习
//
//  Created by GXJ on 16/3/17.
//  Copyright © 2016年 GXJ. All rights reserved.
//

#import "XJActionSheet.h"
#import "XJActionSheetCell.h"

#define gPushTime 0.3
#define gWH ([[UIScreen mainScreen] bounds].size.height)
#define gWW ([[UIScreen mainScreen] bounds].size.width)
#define gCornerRadius 8
#define gMargin 10//两边的距离
#define gCellH 50//单元格高度
#define gSeparateHeight 8

@interface XJActionSheet()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIButton *bgButton;
@property (nonatomic,strong)UIView *containview;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIButton *cancelButton;

@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSArray *imageArray;
@property (nonatomic,assign)NSInteger lineNumber;

@end

@implementation XJActionSheet

#pragma mark -- public method
- (id)initWithTitle:(NSArray *)titleArray image:(NSArray *)images showLineNumber:(NSInteger)lineNumber andScroll:(BOOL)flag {
    if(self = [super initWithFrame:[[UIScreen mainScreen] bounds]]) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        
        _titleArray = titleArray;
        _imageArray = images;
        _lineNumber = lineNumber;
        
        [self addSubview:self.bgButton];
        [self addSubview:self.containview];
        [self.containview addSubview:self.tableView];
        self.tableView.scrollEnabled = flag;
        [self.containview addSubview:self.cancelButton];
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
            self.tableView.separatorInset = UIEdgeInsetsMake(0, gWW, 0, gWH);
        }
        [self pushView];
    }
    return self;
}

#pragma mark -- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XJActionSheetCell *cell = [XJActionSheetCell cellWithTableView:tableView];
    cell.titleString = _titleArray[indexPath.row];
    if (indexPath.row < _imageArray.count) {
        cell.imageString = _imageArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(sheetViewDidSelectIndex:title:)]) {
        [self.delegate sheetViewDidSelectIndex:indexPath.row title:_titleArray[indexPath.row]];
    }
    [self dismissDefaulfSheetView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return gCellH;
}

#pragma mark -- private method
- (void)pushView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        
        if (_titleArray.count < _lineNumber) {
            if (kDevice_Is_iPhoneX) {
                weakSelf.containview.frame = CGRectMake(gMargin,gWH - gCellH * _titleArray.count - gCellH - gSeparateHeight - 34,gWW - 2 * gMargin,gCellH * _titleArray.count + gCellH + gSeparateHeight);
            }else {
                weakSelf.containview.frame = CGRectMake(gMargin,gWH - gCellH * _titleArray.count - gCellH - gSeparateHeight - gSeparateHeight,gWW - 2 * gMargin,gCellH*_titleArray.count + gCellH + gSeparateHeight);
            }
        } else {
            if (kDevice_Is_iPhoneX) {
                weakSelf.containview.frame = CGRectMake(gMargin,gWH - gCellH * _lineNumber - gCellH - gSeparateHeight - 34,gWW - 2 * gMargin,gCellH * _lineNumber + gCellH + gSeparateHeight);
            }else {
                weakSelf.containview.frame = CGRectMake(gMargin,gWH - gCellH * _lineNumber - gCellH - gSeparateHeight - gSeparateHeight,gWW - 2 * gMargin,gCellH * _lineNumber + gCellH + gSeparateHeight);
            }
        }
    }];
}

- (void)dismissDefaulfSheetView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        if (_titleArray.count < _lineNumber) {
            weakSelf.containview.frame = CGRectMake(gMargin, gWH, gWW-2*gMargin, gCellH*_titleArray.count+gCellH+gSeparateHeight);
        }
        
        else {
            weakSelf.containview.frame = CGRectMake(gMargin, gWH, gWW-2*gMargin, gCellH*_lineNumber+gCellH+gSeparateHeight);
            weakSelf.bgButton.alpha = 0.0;
        }
    } completion:^(BOOL finished) {
        [weakSelf.containview removeFromSuperview];
        [weakSelf.bgButton removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}

#pragma mark -- getters
- (UIButton *)bgButton {
    if (!_bgButton) {
        _bgButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, gWW, gWH)];
        
        _bgButton.backgroundColor = [UIColor blackColor];
        _bgButton.alpha = 0.3;
        [_bgButton addTarget:self action:@selector(dismissDefaulfSheetView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgButton;
}

- (UIView *)containview {
    if (!_containview) {
        if(_titleArray.count < _lineNumber) {
            _containview = [[UIView alloc]initWithFrame:CGRectMake(gMargin,gWH,gWW-2*gMargin,gCellH*_titleArray.count+gCellH+gSeparateHeight)];
        } else {
            _containview = [[UIView alloc]initWithFrame:CGRectMake(gMargin,gWH,gWW-2*gMargin,gCellH*_lineNumber+gCellH+gSeparateHeight)];
        }
        _containview.backgroundColor = [UIColor clearColor];
        _containview.layer.cornerRadius = gCornerRadius;
    }
    return _containview;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, gWW-2*gMargin, _containview.frame.size.height-gCellH-gSeparateHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = gCornerRadius;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame)+gSeparateHeight, gWW-2*gMargin, gCellH)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithHexString:@"#007AFF"] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:20];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        _cancelButton.layer.cornerRadius = gCornerRadius;
        [_cancelButton addTarget:self action:@selector(dismissDefaulfSheetView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

@end

