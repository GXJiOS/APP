//
//  GXJPagesViewController.m
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import "GXJPagesViewController.h"
#import "GXJTopTitleView.h"

@interface GXJPagesViewController ()<GXJTopTitleViewDelegate, UIScrollViewDelegate>
@property (nonatomic,strong)NSArray *controllersArr;
@property (nonatomic,assign)NSInteger onepageNumber;
@property (nonatomic,assign)TitleLenthType titleLenthType;
@property (nonatomic,assign)float labelMargin;
@property (nonatomic,assign)UIColor *normalColor;
@property (nonatomic,assign)UIColor *selectColor;
@property (nonatomic,assign)CGFloat normalFont;
@property (nonatomic,assign)CGFloat selectFont;
@property (nonatomic,assign)CGRect frame;

@property (nonatomic, strong) GXJTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSMutableArray *titles;


@end

@implementation GXJPagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}
- (void)setCanBounces:(BOOL)canBounces {
    _canBounces = canBounces;
    _topTitleView.bounces = canBounces;
}

- (void)setLineColor:(UIColor *)lineColor {
    lineColor = lineColor;
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.backgroundColor = lineColor.CGColor;
    bottomLayer.frame = CGRectMake(_frame.origin.x ,CGRectGetMaxY(_topTitleView.frame),_frame.size.width , 1.0);
    [self.view.layer addSublayer:bottomLayer];
}

- (void)setArray:(NSArray *)array {
    _array = array;
    [self setUpControllersArr:_array];
}

//标题长度动态化
- (instancetype)initWithLabelMargin:(float)labelMargin titleArray:(NSArray *)titleArray normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor normalfont:(CGFloat)normalFont selectfont:(CGFloat)selectFont frame:(CGRect)frame {
    self = [super init];
    if (self) {
        
        _titleLenthType = AUTOLENGTH;
        _labelMargin    = labelMargin;
        _controllersArr = titleArray;
        _normalColor    = normalColor;
        _selectColor    = selectColor;
        _normalFont     = normalFont;
        _selectFont     = selectFont;
        _frame          = frame;
        
        [self setUpControllersArr:_controllersArr];
        
    }
    return self;
}

//标题长度固定
- (instancetype)initWithTitleLengthType:(TitleLenthType)titleLenthType onepageNumber:(NSInteger)onepageNumber titleArray:(NSArray *)titleArray normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor normalfont:(CGFloat)normalFont selectfont:(CGFloat)selectFont frame:(CGRect)frame {
    self = [super init];
    if (self) {
        
        _titleLenthType = titleLenthType;
        _onepageNumber  = onepageNumber;
        _controllersArr = titleArray;
        _normalColor    = normalColor;
        _selectColor    = selectColor;
        _normalFont     = normalFont;
        _selectFont     = selectFont;
        _frame          = frame;
        
        [self setUpControllersArr:_controllersArr];
        
    }
    return self;
}

- (void)setUpControllersArr:(NSArray *)controllersArr {
    _controllersArr = controllersArr;
    _titles = [[NSMutableArray alloc]init];
    // 1.添加所有子控制器
    for(int i = 0;i<_controllersArr.count ; i++) {
        [self addChildViewController:_controllersArr[i]];
        [_titles addObject:[_controllersArr[i] title]];
    }

    _topTitleView = [GXJTopTitleView topTitleViewWithFrame:CGRectMake(_frame.origin.x, _frame.origin.y, _frame.size.width, 40)];
    
    switch (_titleLenthType) {
        case AUTOLENGTH:
        {
            _topTitleView.labelMargin = _labelMargin;//单页显示按钮的个数
        }
            break;
            
        default:
            _topTitleView.showNumber = _onepageNumber;//单页显示按钮的个数
            break;
    }
    _topTitleView.normalColor = _normalColor;
    _topTitleView.selectColor = _selectColor;
    _topTitleView.normalFont  = _normalFont;
    _topTitleView.selectFont  = _selectFont;
    _topTitleView.titleLengthType = _titleLenthType;//标题长度类型
    _topTitleView.scrollTitleArr = _titles;
    _topTitleView.delegate_GXJ = self;
    
    [self.view addSubview:_topTitleView];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(_frame.origin.x, CGRectGetMaxY(self.topTitleView.frame), _frame.size.width, _frame.size.height - _topTitleView.frame.size.height);
    
    _mainScrollView.contentSize = CGSizeMake(_frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 有弹簧效果
    _mainScrollView.bounces = YES;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    
    [self.view addSubview:_mainScrollView];
    
    [self showVc:0];
    
}

//点击头部
- (void)GXJTopTitleView:(GXJTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index {
    // 1 计算滚动的位置
    CGFloat offsetX = index * _frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * _frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, _frame.size.width, self.mainScrollView.frame.size.height);
}

//手势滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    [_topTitleView scrollTitleLabelScrollCenter:index];
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
    
    // 3.滚动时，改变标题选中
    [self.topTitleView scrollTitleLabelSelecteded:selLabel];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
