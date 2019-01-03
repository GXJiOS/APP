//
//  GXJTopTitleView.m
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "GXJTopTitleView.h"
#import "UIView+GXJExtension.h"

@interface GXJTopTitleView()

/** 滚动标题Label */
@property (nonatomic, strong) UILabel *scrollTitleLabel;
/** 选中标题时的Label */
@property (nonatomic, strong) UILabel *selectedTitleLabel;
/** 指示器 */
@property (nonatomic, strong) UIView *indicatorView;
/**当前选中 */
@property (nonatomic,assign) NSInteger selectOne;
@end

@implementation GXJTopTitleView

/** 指示器的高度 */
static CGFloat const indicatorHeight = 1.5;

- (NSMutableArray *)allTitleLabel {
    if (_allTitleLabel == nil) {
        _allTitleLabel = [NSMutableArray array];
        
    }
    return _allTitleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
        self.showsHorizontalScrollIndicator = NO;
        _selectOne = 0;
    }
    return self;
}

+ (instancetype)topTitleViewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"a");
}

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
}

- (void)setSelectColor:(UIColor *)selectColor {
    _selectColor = selectColor;
}

- (void)setNormalFont:(CGFloat)normalFont {
    _normalFont = normalFont;
}

- (void)setSelectFont:(CGFloat)selectFont {
    _selectFont = selectFont;
}

- (void)setShowNumber:(NSInteger)showNumber {
    _showNumber = showNumber;
}

- (void)setTitleLengthType:(TitleLenthType)titleLengthType {
    _titleLengthType = titleLengthType;
}

#pragma mark - - - 重写滚动标题数组的setter方法
- (void)setScrollTitleArr:(NSArray *)scrollTitleArr {
    
    _scrollTitleArr = scrollTitleArr;
    
    CGFloat labelH = self.frame.size.height - indicatorHeight;
    
    if (_titleLengthType == AUTOLENGTHSTATICNUM) {
        [self countLabelMargin];
    }
    else if (_titleLengthType == AUTOLENGTH) {
        [self countShowNum];
    }
    
    CGFloat labelX = _labelMargin/2;
    CGFloat labelY = 0;
    
    
    for (NSUInteger i = 0; i < self.scrollTitleArr.count; i++) {
        /** 创建滚动时的标题Label */
        self.scrollTitleLabel = [[UILabel alloc] init];
        _scrollTitleLabel.textColor = _normalColor;
        _scrollTitleLabel.userInteractionEnabled = YES;
        _scrollTitleLabel.text = self.scrollTitleArr[i];
        _scrollTitleLabel.textAlignment = NSTextAlignmentCenter;
        _scrollTitleLabel.tag = i;
        _scrollTitleLabel.font = [UIFont systemFontOfSize:_normalFont];
        
        // 设置高亮文字颜色
        _scrollTitleLabel.highlightedTextColor = _selectColor;
        
        CGFloat labelW;
        switch (_titleLengthType) {
            case AUTOLENGTH:
            {
                //计算内容的Size
                CGSize labelSize = [self sizeWithText:_scrollTitleLabel.text font:[UIFont systemFontOfSize:_normalFont] maxSize:CGSizeMake(MAXFLOAT, labelH)];
                //计算内容的宽度
                labelW = labelSize.width +  _labelMargin;
            }
                break;
                
            case STATICLENGTH: case AUTOTOTEXT:
            {
                labelW = self.frame.size.width / _showNumber;
            }
                break;
                
            default:
            {
                CGSize labelSize = [self sizeWithText:_scrollTitleLabel.text font:[UIFont systemFontOfSize:_normalFont] maxSize:CGSizeMake(MAXFLOAT, labelH)];
                
                labelW = labelSize.width +  _labelMargin;
                    
            }
                break;
        }
        
        _scrollTitleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
        // 计算每个label的X值
        labelX = labelX + labelW;
        
        // 添加到titleLabels数组
        [self.allTitleLabel addObject:_scrollTitleLabel];
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTitleClick:)];
        [_scrollTitleLabel addGestureRecognizer:tap];
        
        // 默认选中第0个label
        if (i == 0) {
            [self scrollTitleClick:tap];
        }
        
        [self addSubview:_scrollTitleLabel];
    }
    
    // 计算scrollView的宽度
    CGFloat scrollViewWidth = CGRectGetMaxX(self.subviews.lastObject.frame);
    self.contentSize = CGSizeMake(scrollViewWidth, self.frame.size.height);
    
    // 取出第一个子控件
    UILabel *firstLabel = self.subviews.firstObject;
    
    // 添加指示器
    self.indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = _selectColor;
    _indicatorView.GXJ_height = indicatorHeight;
    _indicatorView.GXJ_y = self.frame.size.height - indicatorHeight;
    [self addSubview:_indicatorView];
    
    // 指示器默认在第一个选中位置
    switch (_titleLengthType) {
        case STATICLENGTH:
        {
            _indicatorView.GXJ_width = self.frame.size.width / _showNumber;
        }
            break;
            
        default:
        {
            // 计算TitleLabel内容的Size
            CGSize labelSize = [self sizeWithText:firstLabel.text font:[UIFont systemFontOfSize:_selectFont] maxSize:CGSizeMake(MAXFLOAT, labelH)];
            _indicatorView.GXJ_width = labelSize.width;
        }
            break;
    }
    
    _indicatorView.GXJ_centerX = firstLabel.GXJ_centerX;
}

#pragma mark --- 计算标题间距
- (void)countLabelMargin {
    float sumlength = 0;
    if (self.scrollTitleArr.count < _showNumber) {
        for (NSUInteger i = 0; i < self.scrollTitleArr.count; i++) {
            
            CGSize labelSize = [self sizeWithText:self.scrollTitleArr[i] font:[UIFont systemFontOfSize:_normalFont] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            
            sumlength += labelSize.width;
        }
        _labelMargin = (self.frame.size.width - sumlength)/(self.scrollTitleArr.count+1);
    }
    else {
        for (NSUInteger i = 0; i < _showNumber; i++) {
            CGSize labelSize = [self sizeWithText:self.scrollTitleArr[i] font:[UIFont systemFontOfSize:_normalFont] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            
            sumlength += labelSize.width;
        }
        _labelMargin = (self.frame.size.width - sumlength)/(_showNumber+1);
    }
}

#pragma mark --- 计算单页显示个数
- (void)countShowNum {
    float sumlength = _labelMargin;
    _showNumber = self.scrollTitleArr.count;
    for (NSUInteger i = 0; i < self.scrollTitleArr.count; i++) {
        CGSize labelSize = [self sizeWithText:self.scrollTitleArr[i] font:[UIFont systemFontOfSize:_normalFont] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        
        sumlength = sumlength + labelSize.width + _labelMargin;
        
        if(sumlength > self.frame.size.width) {
            _showNumber = i + 1 ;
            NSLog(@"======%ld",_showNumber);
            return;
        }
    }
}

/** scrollTitleClick的点击事件 */
- (void)scrollTitleClick:(UITapGestureRecognizer *)tap {
    // 0.获取选中的label
    UILabel *selLabel = (UILabel *)tap.view;
    
    // 1.标题颜色变成红色,设置高亮状态下的颜色， 以及指示器位置
    [self scrollTitleLabelSelecteded:selLabel];
    
    // 2.让选中的标题居中 (当contentSize 大于self的宽度才会生效)
    [self scrollTitleLabelSelectededCenter:selLabel];
    
    // 3.代理方法实现
    NSInteger index = selLabel.tag;
    if ([self.delegate_GXJ respondsToSelector:@selector(GXJTopTitleView:didSelectTitleAtIndex:)]) {
        [self.delegate_GXJ GXJTopTitleView:self didSelectTitleAtIndex:index];
    }
}

/** 滚动标题选中颜色改变以及指示器位置变化 */
- (void)scrollTitleLabelSelecteded:(UILabel *)label {
    
    // 取消高亮
    _selectedTitleLabel.highlighted = NO;
    
    // 颜色恢复
    _selectedTitleLabel.textColor = _normalColor;
    _selectedTitleLabel.font = [UIFont systemFontOfSize:_normalFont];
    // 高亮
    label.highlighted = YES;
    label.font = [UIFont systemFontOfSize:_selectFont];
    
    _selectedTitleLabel = label;
    
    // 改变指示器位置
    [UIView animateWithDuration:0.2 animations:^{
        
        switch (_titleLengthType) {
                
            case STATICLENGTH:
            {
                self.indicatorView.GXJ_width = self.frame.size.width / _showNumber;
            }
                break;
                
            default:
            {
                // 计算TitleLabel内容的Size
                CGSize labelSize = [self sizeWithText:label.text font:[UIFont systemFontOfSize:_selectFont] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                self.indicatorView.GXJ_width = labelSize.width;
            }
                break;
        }
        self.indicatorView.GXJ_centerX = label.GXJ_centerX;
    }];
}

/** 滚动标题选中居中 */
- (void)scrollTitleLabelSelectededCenter:(UILabel *)centerLabel {
    
    if (_scrollTitleArr.count > _showNumber) {
        // 计算偏移量
        CGFloat offsetX = centerLabel.center.x - self.frame.size.width * 0.5;
        
        if (offsetX < 0) offsetX = 0;
        
        // 获取最大滚动范围
        CGFloat maxOffsetX = self.contentSize.width - self.frame.size.width;
        
        if (offsetX > maxOffsetX) offsetX = maxOffsetX;
        
        // 滚动标题滚动条
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

/** 滑动时标题选中居中 */
- (void)scrollTitleLabelScrollCenter:(NSInteger)index {
    
    if (_scrollTitleArr.count > _showNumber) {
        UILabel *label = [self viewWithTag:index];
        CGFloat offsetX = label.center.x - self.frame.size.width * 0.5;
        
        // 计算偏移量
        if(index<_showNumber/2)
        {
            offsetX = 0;
        }
        
        // 获取最大滚动范围
        CGFloat maxOffsetX = self.contentSize.width - self.frame.size.width;
        
        if (offsetX > maxOffsetX) offsetX = maxOffsetX;
        
        // 滚动标题滚动条
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

@end
