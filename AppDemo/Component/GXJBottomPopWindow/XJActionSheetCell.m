//
//  XJActionSheetCell.m
//  X16.YiXiuDaC
//
//  Created by GXJ on 2016/10/25.
//  Copyright © 2016年 GXJ. All rights reserved.
//

#import "XJActionSheetCell.h"

@interface XJActionSheetCell()
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UIButton *button;
@end


@implementation XJActionSheetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
    
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellsign = @"XJActionSheetCell";
    XJActionSheetCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[XJActionSheetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
    
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.button];
        [self addSubview:self.label];
    }
    return self;
}
    
- (void)layoutSubviews {
    [super layoutSubviews];
    self.button.frame = CGRectMake(44, 0, 44, 44);
    self.label.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

#pragma mark -- setters
- (void)setTitleString:(NSString *)titleString {
    self.label.text = titleString;
}

- (void)setImageString:(NSString *)imageString {
    [self.button setImage:[UIImage imageNamed:imageString] forState:0];
    self.label.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 10, 0, self.frame.size.width - CGRectGetMaxX(self.imageView.frame) - 10, self.frame.size.height);
}

#pragma mark -- getters
- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc]init];
    }
    return _button;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.textAlignment = 1;
        _label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
    }
    return _label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
