//
//  XJActionSheetCell.h
//  X16.YiXiuDaC
//
//  Created by GXJ on 2016/10/25.
//  Copyright © 2016年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJActionSheetCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,copy)NSString *imageString;
@property (nonatomic,copy)NSString *titleString;
@end
