//
//  BSTabBarController.h
//  LotterySelect
//
//  Created by 刘鹏 on 15/11/26.
//  Copyright © 2015年 SEU. All rights reserved.
//

#import <RDVTabBarController/RDVTabBarController.h>
#import <RDVTabBarController/RDVTabBar.h>
#import <RDVTabBarController/RDVTabBarItem.h>


/*!
 @class
 @abstract 自定义TabBarController。
 */
@interface BSTabBarController : RDVTabBarController

@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) NSUInteger oldSelectedIndex;

@end
