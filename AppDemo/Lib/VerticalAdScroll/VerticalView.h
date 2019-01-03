//
//  VerticalView.h
//  zjGovernment
//
//  Created by GXJ on 2017/5/10.
//  Copyright © 2017年 胡胜冬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerticalView : UIView

/** 设置本身阴影的透明度 */
@property(nonatomic, assign) CGFloat customAlpha;

/** 数据源 */
@property(nonatomic, strong) NSDictionary *superDataDic;

@property (nonatomic,assign) NSInteger index;



@end
