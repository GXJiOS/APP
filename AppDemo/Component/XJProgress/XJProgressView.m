//
//  XJProgressView.m
//  AppFrame
//
//  Created by GXJ on 2017/4/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "XJProgressView.h"

#define KHWCircleFont [UIFont boldSystemFontOfSize:26.0f]

@interface XJProgressView()

@property (nonatomic,assign)ProgressType type;
@property (nonatomic,assign)CGFloat endTime;
@property (nonatomic,assign)CGFloat nowProgress;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)CGFloat startAngle;
@property (nonatomic,strong)UIColor *color;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,strong)UILabel *label;

@property (nonatomic, weak) UIView *tView;
@end

@implementation XJProgressView
{
    UIBezierPath *path;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _type = CIRCLEPROGRESS;
        _endTime = 1.0;
        _nowProgress = 0.0;
        _startAngle = 1.5;
        _color = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1];
        _width = 10.0f;
    }
    
    return self;
}

- (void)setProgressType:(ProgressType)progressType {
    _type = progressType;
    
    if (_type == CIRCLEPROGRESS) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _label.textAlignment = 1;
        _label.font = [UIFont systemFontOfSize:16];
        [self addSubview:_label];
        
        
    }
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress <= 1 ? progress : 1.0;
    
    //_cLabel.text = [NSString stringWithFormat:@"%d%%", (int)floor(progress * 100)];
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _color = strokeColor;
}

- (void)setStrokeWidth:(CGFloat)strokeWidth {
    _width = strokeWidth;
}

- (void)setFinishTime:(CGFloat)finishTime {
    _endTime = finishTime;

    [self setNeedsDisplay];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_endTime / 100 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)drawRect:(CGRect)rect {
    
    switch (_type) {
        case CIRCLEPROGRESS:
        {
            [self setCircle];
        }
            break;
            
        default:
            break;
    }
}

- (void)setCircle {
    //路径
    path = [[UIBezierPath alloc] init];
    //线宽
    path.lineWidth = _width;
    //颜色
    [_color set];
    //拐角
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    //半径
    CGFloat radius = (MIN(self.frame.size.width, self.frame.size.height) - _width) * 0.5;
    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [path addArcWithCenter:(CGPoint){self.frame.size.width * 0.5, self.frame.size.height * 0.5} radius:radius startAngle:M_PI * _startAngle endAngle:M_PI * _startAngle + M_PI * 2 * _nowProgress clockwise:YES];
    //连线
    [path stroke];
    
    _label.textColor = _color;
    _label.text = [NSString stringWithFormat:@"%d%%", (int)floor(_nowProgress * 100)];
}

- (void)timerAction
{
    if (_nowProgress >= _progress) {
        [self removeTimer];
        NSLog(@"完成");
        return;
    }
    [self setNeedsDisplay];
    _nowProgress += (_progress / 100);
}

- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}
@end
