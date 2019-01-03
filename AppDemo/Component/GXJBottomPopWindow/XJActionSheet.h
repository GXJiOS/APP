//
//  XJActionSheet.h
//  弹窗练习
//
//  Created by GXJ on 16/3/17.
//  Copyright © 2016年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJActionSheet.h"

@protocol XJActionSheetDelegate <NSObject>

- (void)sheetViewDidSelectIndex:(NSInteger)index title:(NSString *)title;

@end

@interface XJActionSheet : UIView

- (id)initWithTitle:(NSArray *)titleArray image:(NSArray *)images showLineNumber:(NSInteger)lineNumber andScroll:(BOOL)flag;
@property (nonatomic,weak)id<XJActionSheetDelegate>delegate;

@end
