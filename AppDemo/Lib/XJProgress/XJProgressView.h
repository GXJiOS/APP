//
//  XJProgressView.h
//  AppFrame
//
//  Created by GXJ on 2017/4/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ProgressType)
{
    CIRCLEPROGRESS,
    WAVEPROGRESS,
    INSTALLPROGRESS
};

@interface XJProgressView : UIView
@property (nonatomic,assign)ProgressType progressType;
@property (nonatomic,assign)CGFloat progress;
@property (nonatomic,strong)UIColor *strokeColor;
@property (nonatomic,assign)CGFloat strokeWidth;
@property (nonatomic,assign)CGFloat finishTime;

@end
