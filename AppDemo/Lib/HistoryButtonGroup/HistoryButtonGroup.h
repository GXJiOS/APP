//
//  HistoryButtonGroup.h
//  AppFrame
//
//  Created by GXJ on 2017/3/30.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HistoryButtonGroupClearDelegate <NSObject>

@optional
- (void)rigthAction;

@end

@interface HistoryButtonGroup : UIView

/**
 *  初始化
 *
 *  @param array        按钮数组
 *  @param originalX    初始X
 *  @param originalY    初始Y
 *  @param buttonHM     水平间距
 *  @param buttonVM     垂直间距
 *  @param buttonHeight 按钮高度
 *  @param textFont     按钮字体
 
 */

- (instancetype)initWithTitle:(NSString *)title
                  buttonGroup:(NSArray *)array
                    originalX:(float)originalX
                    originalY:(float)originalY
                     buttonHM:(float)buttonHM
                     buttonVM:(float)buttonVM
                 buttonHeight:(float)buttonHeight
                     textFont:(float)textFont;

@property (nonatomic,assign) UIColor *textColor;//字体颜色 默认黑色
@property (nonatomic,assign) UIColor *boderColor;//边框颜色 默认浅灰
@property (nonatomic,assign) UIColor *backColor;//按钮带背景色 默认带边框背景色白色

@property (nonatomic,strong) NSString *imageName;//右按钮 默认无

typedef void (^buttonBlock)(NSString *title);
@property (nonatomic,strong) buttonBlock block;

@property (nonatomic,weak) id <HistoryButtonGroupClearDelegate>delegate;

@end
