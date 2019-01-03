//
//  CommonMacro.h
//  AppFrame
//
//  Created by GXJ on 2017/2/24.
//  Copyright © 2017年 GXJ. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

/* 常用字体宏 */
#define HEITIMEDIUM @"STHeitiSC-Medium"     // 黑体－简－中等
#define HEITILIGHT  @"STHeitiSC-Light"      // 黑体－简－细体
#define XINGKAIMEDIUM   @"迷你简行楷"
#define XINGKAILIGHT    @"迷你简细行楷"

/* RGB颜色宏 */
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]      // RGB颜色值（带透明度）
#define RGB(r,g,b) RGBA(r,g,b,1.0f)     // RGB颜色值（不透明）

#define ColorString(X) [UIColor colorWithHexString:(X)]
#define APPCOLOR RGB(41,148,249)

#define WEAKSELF  __weak typeof(self) weakSelf = self ;

/* 设备屏幕宏 */
#define kSCREENFRAME [[UIScreen mainScreen] bounds]  // 当前屏幕frmae
#define kSCREENWIDTH kSCREENFRAME.size.width          // 当前屏幕宽度
#define kSCREENHEIGHT kSCREENFRAME.size.height        // 当前屏幕高度

/* 设备型号 */
#define iPhone4S (SCREENHEIGHT == 480)

/* 常用路径 */
#define ROOTPATH [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]   // app根目录路径

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#endif
