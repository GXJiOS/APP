//
//  GXJPagesViewController.h
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TitleLenthType)
{
    AUTOLENGTH,   /*标题长度不定 且 指示器长度根据字长变化  (标题字数不相同且单页个数不限制时使用)*/
    AUTOLENGTHSTATICNUM,   /*标题长度不定 且 指示器长度根据字长变化  (标题字数不相同且单页个数固定时使用)*/
    STATICLENGTH, /*标题长度固定 且 指示器长度是固定长度   (标题字数相同时使用)*/
    AUTOTOTEXT    /*标题长度固定 且 指示器长度根据字长变化 (标题字数相同时使用)*/
    
};

@interface GXJPagesViewController : UIViewController

/*标题是否有回弹效果*/
@property (nonatomic,assign)BOOL canBounces;
/**/
@property (nonatomic,assign)UIColor *lineColor;

@property (nonatomic,strong)NSArray *array;

/**
 *  AUTOLENGTH
 *
 *  @param labelMargin    标题间隔
 *  @param titleArray     控制器数组
 
 */

- (instancetype)initWithLabelMargin:(float)labelMargin
                         titleArray:(NSArray *)titleArray
                        normalColor:(UIColor *)normalColor
                        selectColor:(UIColor *)selectColor
                         normalfont:(CGFloat)normalFont
                         selectfont:(CGFloat)selectFont
                              frame:(CGRect)frame;

/**
 *  AUTOLENGTHSTATICNUM STATICLENGTH AUTOTOTEXT
 *
 *  @param onepageNumber  单页显示标题个数
 *  @param titleArray     控制器数组
 
 */
- (instancetype)initWithTitleLengthType:(TitleLenthType)titleLenthType
                          onepageNumber:(NSInteger)onepageNumber
                             titleArray:(NSArray *)titleArray
                            normalColor:(UIColor *)normalColor
                            selectColor:(UIColor *)selectColor
                             normalfont:(CGFloat)normalFont
                             selectfont:(CGFloat)selectFont
                                  frame:(CGRect)frame;


@end
