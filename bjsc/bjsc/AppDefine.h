//
//  AppDefine.h
//  幻想城市
//
//  Created by 幻想城市ios1 on 2017/8/11.
//  Copyright © 2017年 幻想城市ios1. All rights reserved.
//

#ifndef AppDefine_h
#define AppDefine_h


//AppDelegate
#define APP_DELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

// 应用程序的名字
#define APP_NAME [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

// 应用程序版本号
#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

// 沙盒Document路径
#define AppDocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define ScoreURL(id) [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/guang-dian-bi-zhi/id%d?mt=8",id] //app store 评分

#define ServicePhone @"400" //400客服电话

#define ITUNES_APP_KEY 100000

/**
 * 图片
 * 文字大小
 * 颜色
 */
#define GetImage(imageName) [UIImage imageNamed:imageName]
#define GetFont(x) [UIFont systemFontOfSize:x]
#define GetBoldFont(x) [UIFont boldSystemFontOfSize:x]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBCOLORV(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]
#define RGBCOLORVA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define SCREEN_LeftOffSet 15
#define SCREEN_RightOffSet 15

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//版本判断
#define IsIphone5 (SCREEN_HEIGHT == 568) ? YES:NO
#define IsIphone6 (SCREEN_HEIGHT == 667) ? YES:NO
#define IsIphone6Plus (SCREEN_HEIGHT == 736) ? YES:NO

//获取当前屏幕的宽高
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width


// 登陆监听
#define kNotificationLoginStateChanged              @"kNotificationLoginStateChanged"

// 沙盒Document路径
#define AppDocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kWindow [[[UIApplication sharedApplication] delegate] window]




#endif /* AppDefine_h */
