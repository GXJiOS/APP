


#import "GXJPopTool.h"

static NSTimeInterval const kFadeInAnimationDuration = 0.2;
static NSTimeInterval const kTransformPart1AnimationDuration = 0.2;
static NSTimeInterval const kTransformPart2AnimationDuration = 0.2;
static CGFloat const kDefaultCloseButtonPadding = 0.0f;
static CGFloat const kDefaultCloseButtonWidth = 20.0f;
/**
 *  自定义的view
 */
@interface MyView : UIView
@property (weak, nonatomic) CALayer *styleLayer;
@property (strong, nonatomic) UIColor *popBackgroundColor;
@end

//遮罩
@interface shadeView : UIView
@property (nonatomic,assign)BOOL closeAnimated;
@end

/**
 *  自定义的VC
 */
@interface MyViewController : UIViewController
@property (weak, nonatomic) shadeView *styleView;
@end

/**
 *  自定义的button
 */
@interface MyButton : UIButton

@end

/**
 *  GXJPopTool
 */
@interface GXJPopTool ()
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *contentViewController;
@property (weak, nonatomic) MyViewController *viewController;
@property (weak, nonatomic) MyView *containerView;
@property (weak, nonatomic) MyButton *closeButton;

@end

@implementation GXJPopTool

+ (GXJPopTool *)sharedInstance {
    static GXJPopTool *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[GXJPopTool alloc]init];
    });
    return sharedClient;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.closeButtonType = ButtonPositionTypeRight;
        self.tapOutsideToDismiss = YES;
//        self.popBackgroudColor = [UIColor colorWithWhite:1 alpha:0.5];
        self.closeAnimated = NO;
    };
    return self;
}

- (void)setCloseButtonType:(ButtonPositionType)closeButtonType {
    
    _closeButtonType = closeButtonType;
    if (closeButtonType == ButtonPositionTypeNone) {
        [self.closeButton setHidden:YES];
    } else {
        [self.closeButton setHidden:NO];
        /*修改关闭按钮位置*/
        CGRect closeFrame;
        if(closeButtonType == ButtonPositionTypeRight){
            closeFrame.size.width = closeFrame.size.height = kDefaultCloseButtonWidth;
            closeFrame.origin.x = CGRectGetWidth(self.containerView.frame) - kDefaultCloseButtonPadding - CGRectGetWidth(closeFrame);
            closeFrame.origin.y = 0;
            
        } else {
            closeFrame.size.width = closeFrame.size.height = kDefaultCloseButtonWidth;
            closeFrame.origin.x = 0;
            closeFrame.origin.y = 0;
        }
        self.closeButton.frame = closeFrame;
    }
}

- (void)showWithPresentView:(UIView *)presentView animated:(BOOL)animated {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    
    MyViewController *viewController = [[MyViewController alloc] init];
    self.window.rootViewController = viewController;
    self.viewController = viewController;
    
    CGFloat padding = 0;
    CGRect containerViewRect = CGRectInset(presentView.bounds, -padding, -padding);
    containerViewRect.origin.x = containerViewRect.origin.y = 0;
    containerViewRect.origin.x = round(CGRectGetMidX(self.window.bounds) - CGRectGetMidX(containerViewRect));
    containerViewRect.origin.y = round(CGRectGetMidY(self.window.bounds) - CGRectGetMidY(containerViewRect));
    MyView *containerView = [[MyView alloc] initWithFrame:containerViewRect];
    containerView.popBackgroundColor = self.popBackgroudColor;
    containerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    containerView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    presentView.frame = (CGRect){padding, padding, presentView.bounds.size};
    [containerView addSubview:presentView];
    [viewController.view addSubview:containerView];
    self.containerView = containerView;
    
    MyButton *closeButton = [[MyButton alloc] init];

    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:closeButton];
    self.closeButton = closeButton;
    [self setCloseButtonType:self.closeButtonType];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.window makeKeyAndVisible];
        if(animated){
            viewController.styleView.alpha = 0;
            viewController.styleView.closeAnimated = self.closeAnimated;
            [UIView animateWithDuration:kFadeInAnimationDuration animations:^{
                viewController.styleView.backgroundColor = self.popBackgroudColor;
                viewController.styleView.alpha = 1;
            }];
            containerView.alpha = 0;
            containerView.layer.shouldRasterize = YES;
            containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
            [UIView animateWithDuration:kTransformPart1AnimationDuration animations:^{
                containerView.alpha = 1;
                containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:.2 animations:^{
                    containerView.alpha = 1;
                    containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:kTransformPart2AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        containerView.alpha = 1;
                        containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                    } completion:^(BOOL finished2) {
                        containerView.layer.shouldRasterize = NO;
                    }];
                    
                }];
            }];
        }
    });
    
}

- (void)close {
    [self hideAnimated:self.closeAnimated withCompletionBlock:nil];
    if ([self.delegate respondsToSelector:@selector(closeAnimated)]) {
        [self.delegate closeAction];
    }
    
}

- (void)closeWithBlcok:(void(^)())complete {
    [self hideAnimated:self.closeAnimated withCompletionBlock:complete];
}

- (void)hideAnimated:(BOOL)animated withCompletionBlock:(void(^)())completion {
    if(!animated){
        [self cleanup];
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kFadeInAnimationDuration animations:^{
            self.viewController.styleView.alpha = 0;
        }];
        
        self.containerView.layer.shouldRasterize = YES;
//        [UIView animateWithDuration:kTransformPart2AnimationDuration animations:^{
//            self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
//        } completion:^(BOOL finished){
            [UIView animateWithDuration:kTransformPart1AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.containerView.alpha = 0;
                self.containerView.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
            } completion:^(BOOL finished2){
                [self cleanup];
                if(completion){
                    completion();
                }
            }];
//        }];
    });
    
}

- (void)cleanup{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.containerView removeFromSuperview];
    [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
    [self.window removeFromSuperview];
    self.contentViewController = nil;
    self.window = nil;
}
- (void)dealloc{
    [self cleanup];
}


@end

/**
 *  自定义的VC
 */
@implementation MyViewController

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    shadeView *styleView = [[shadeView alloc] initWithFrame:self.view.bounds];
    styleView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    styleView.opaque = NO;
    [self.view addSubview:styleView];
    self.styleView = styleView;
}


@end

/**
 *  自定义的View
 */
@implementation MyView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (!self) {
        CALayer *styleLayer = [[CALayer alloc] init];
        styleLayer.cornerRadius = 4;
        styleLayer.shadowColor= [[UIColor whiteColor] CGColor];
        styleLayer.shadowOffset = CGSizeMake(0, 0);
        styleLayer.shadowOpacity = 0.5;
        styleLayer.borderWidth = 1;
        styleLayer.borderColor = [[UIColor whiteColor] CGColor];
        styleLayer.frame = CGRectInset(self.bounds, 12, 12);
        [self.layer addSublayer:styleLayer];
        self.styleLayer = styleLayer;
        
    }
    return self;
}

- (void)setPopBackgroundColor:(UIColor *)popBackgroundColor {
    if(_popBackgroundColor != popBackgroundColor){
        _popBackgroundColor = popBackgroundColor;
        self.styleLayer.backgroundColor = [popBackgroundColor CGColor];
    }
}

@end

//遮罩

@implementation shadeView

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if ([GXJPopTool sharedInstance].shadeBackgroundType == ShadeBackgroundTypeSolid) {
        
        /*修改蒙版颜色*/
        [[UIColor colorWithWhite:0 alpha:0.3] set];
        CGContextFillRect(context, self.bounds);
    } else {
        CGContextSaveGState(context);
        size_t gradLocationsNum = 2;
        CGFloat gradLocations[2] = {0.0f, 1.0f};
        CGFloat gradColors[8] = {0, 0, 0, 0.3, 0, 0, 0, 0.8};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
        CGColorSpaceRelease(colorSpace), colorSpace = NULL;
        CGPoint gradCenter= CGPointMake(round(CGRectGetMidX(self.bounds)), round(CGRectGetMidY(self.bounds)));
        CGFloat gradRadius = MAX(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        CGContextDrawRadialGradient(context, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
        CGGradientRelease(gradient), gradient = NULL;
        CGContextRestoreGState(context);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([GXJPopTool sharedInstance].tapOutsideToDismiss) {
        [[GXJPopTool sharedInstance] hideAnimated:self.closeAnimated withCompletionBlock:nil];
        [[GXJPopTool sharedInstance].delegate closeAction];
    }
}

@end

/**
 自定义的button
 
 - returns: button
 */
@implementation MyButton

- (instancetype)init {
    
    self = [super initWithFrame:(CGRect){0, 0, 20, 20}];
    if (self) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"close01"] forState:UIControlStateNormal];
        //        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}


@end
