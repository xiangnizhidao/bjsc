//
//  BSViewController.h
//  LotterySelect
//
//  Created by 鹏 刘 on 15/11/23.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @class
 @abstract ViewController基类。
 */
@interface BSViewController : UIViewController


/*!
 @method
 @abstract ViewController 实例化方法。
 @discussion 具体内容子类实现 基类中只做声明。
 @result ViewController 实例
 */
+ (instancetype)viewController;

/*!
 @property
 @abstract 供子类使用Data Array通过get方法创建。
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/*!
 @method
 @abstract 返回方法
 */
- (void)dismissBack:(id)sender;

/*!
 @method
 @abstract 设置左侧返回item。
 */
- (void)setLeftBarButtonItem:(UIBarButtonItem*)barButtonItem;

/*!
 @method
 @abstract 设置右侧返回item。
 */
- (void)setRightBarButtonItem:(UIBarButtonItem*)barButtonItem;

/*!
 @method
 @abstract 左侧返回item。
 @result UIBarButtonItem
 */
- (UIBarButtonItem*)leftBarButtonItem;


/*!
 @method
 @abstract 右侧返回item。
 @result UIBarButtonItem
 */
- (UIBarButtonItem*)rightBarButtonItem;

/*!
 @method
 @abstract  创建一个文字导航按钮。
 @param title 文字
 @param textColor 文字颜色
 @param action barButton事件
 */
- (UIBarButtonItem *)createStringNavBarItem:(NSString *)title
                                  textColor:(UIColor *)textColor
                                     action:(SEL)action;

/*!
 @method
 @abstract  创建一个图片导航按钮。
 @param normalImageName 普通状态图片
 @param heightedImageName 高亮状态图片
 @param action barButton事件
 */
- (UIBarButtonItem *)createImageNavBarItem:(NSString *)normalImageName
                              withHightImg:(NSString *)heightedImageName
                                    action:(SEL)action;

/*!
 @method
 @abstract  创建一个图片返回导航按钮。
 @param normalImageName 普通状态图片
 @param heightedImageName 高亮状态图片
 @param action barButton事件
 */
- (UIBarButtonItem *)createBackImageNavBarItem:(NSString *)normalImageName
                                  withHightImg:(NSString *)heightedImageName
                                        action:(SEL)action;
@end
