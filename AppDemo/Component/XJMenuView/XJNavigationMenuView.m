//
//  XJNavigationMenuView.m
//  DTHybridFrameworkDemo
//
//  Created by GXJ on 2017/9/22.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "XJNavigationMenuView.h"

@interface XJNavigationMenuView ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, strong) UIView *shapeView;

@property (nonatomic,copy)UIColor *titleColor;
@end

@implementation XJNavigationMenuView

- (void)setImageArray:(NSArray *)imageArray {
    NSMutableArray *mutArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (id obj in imageArray) {
        if ([obj isKindOfClass:[NSString class]]) {
            UIImage *image = [UIImage imageNamed:obj];
            [mutArray addObject:image];
        }else if ([obj isKindOfClass:[UIImage class]]) {
            [mutArray addObject:obj];
        }
    }
    _imageArray = mutArray;
}

- (instancetype)initWithPositionOfDirection:(CGPoint)point images:(NSArray *)imageArray titleArray:(NSArray *)titleArray backColor:(UIColor *)backColor titleColor:(UIColor *)titleColor {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _point = point;
        _shapeView = [[UIView alloc] init];
        _shapeView.center = CGPointMake(point.x, point.y + 5);
        _shapeView.bounds = CGRectMake(0, 0, 12, 8);
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
        shapeLayer.position = CGPointMake(6, 4);
        shapeLayer.bounds = CGRectMake(0, 0, 12, 8);
        shapeLayer.fillColor = backColor.CGColor;
        [_shapeView.layer addSublayer:shapeLayer];
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(6, 0)];
        [bezierPath addLineToPoint:CGPointMake(0, 8)];
        [bezierPath addLineToPoint:CGPointMake(12, 8)];
        [bezierPath addLineToPoint:CGPointMake(6, 0)];
        shapeLayer.path = bezierPath.CGPath;
        
        
        _titleArray = titleArray;
        _imageArray = imageArray;
        _titleColor = titleColor;
        
        NSInteger maxLenght = 0;
        NSString *maxString = @"";
        for (NSString *title in _titleArray) {
            if (title.length > maxLenght) {
                maxLenght = title.length;
                maxString = title;
            }
        }
        
        UIFont *font = [UIFont systemFontOfSize:15];
        NSDictionary*attributes = @{NSFontAttributeName:font};
        CGSize size = [maxString boundingRectWithSize:CGSizeMake(self.bounds.size.width - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        CGFloat tableViewW = size.width + 80;
        CGFloat tableViewX = 0.0f;
        CGFloat tableViewH = _titleArray.count * 44;
        if (point.x < self.frame.size.width/2) {
            if (point.x > tableViewW - 8) {
                tableViewX = point.x - tableViewW + 12;
            }else {
                tableViewX = 4;
            }
        }else {
            if (self.frame.size.width - point.x > tableViewW - 8) {
                tableViewX = point.x - 12;
            }else {
                tableViewX = self.frame.size.width - tableViewW - 4;
            }
        }
        BOOL scrollEnabled = NO;
        if (self.frame.size.height - point.y - 15 < tableViewH) {
            tableViewH = self.frame.size.height - point.y - 15;
            scrollEnabled = YES;
        }
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, point.y + 8, tableViewW, tableViewH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = 4;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.scrollEnabled = scrollEnabled;
        _tableView.backgroundColor = backColor;
        [self addSubview:_tableView];
        
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    if ([_imageArray[indexPath.row]isKindOfClass:[UIImage class]]) {
        cell.imageView.image = [_imageArray objectAtIndex:indexPath.row];
    }else if ([_imageArray[indexPath.row]isKindOfClass:[NSString class]]) {
        cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    }else {
        
    }
    
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = _titleColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    if (_clickedBlock) {
        _clickedBlock(indexPath.row);
    }
    if (_delegate && [_delegate respondsToSelector:@selector(navigationMenuView:clickedAtIndex:)]) {
        [_delegate navigationMenuView:self clickedAtIndex:indexPath.row];
    }
    [self disMissSelf];
}

- (void)disMissSelf {
    WEAKSELF
    [UIView animateWithDuration:.2f animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _tableView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        _tableView.alpha = 0.0f;
        _shapeView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        weakSelf.isShow = NO;
        [_shapeView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self disMissSelf];
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        CGRect tableViewFrame = _tableView.frame;
        
        UIViewController *nextResponder = (UIViewController *)[newSuperview nextResponder];
        if (!_shapeView.superview && [nextResponder isKindOfClass:[UIViewController class]]) {
            if (nextResponder.navigationController && _shapeView.frame.origin.y < 64) {
                
                [nextResponder.navigationController.view addSubview:_shapeView];
                tableViewFrame.origin.y = 64;
                _tableView.frame = tableViewFrame;
                
            }else {
                [self addSubview:_shapeView];
            }
        }
        
        _tableView.layer.anchorPoint = CGPointMake((_point.x - tableViewFrame.origin.x)/tableViewFrame.size.width, 0);
        _tableView.center = CGPointMake(_point.x, _point.y + 8);
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _tableView.alpha = 0.0f;
        _shapeView.alpha = 0.0f;
        _tableView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        
        [UIView animateWithDuration:.2f animations:^{
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
            _tableView.transform = CGAffineTransformMakeScale(1, 1);
            _tableView.alpha = 1.0f;
            _shapeView.alpha = 1.0f;
            
        }];
        self.isShow = YES;
    }
    
}

@end
