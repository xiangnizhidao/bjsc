//
//  BSTabBarController.m
//  DingDingClient
//
//  Created by 孙燕飞 on 15/11/26.
//  Copyright © 2015年 SEU. All rights reserved.
//

#import "BSTabBarController.h"
#import "RDVTabBarItem.h"
#import "AppDelegate.h"

#import "HomeViewController.h"
#import "ChartViewController.h"

#define TabBarHeight 49.0f

@interface BSTabBarController ()<UINavigationControllerDelegate,CAAnimationDelegate>

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger number;

@end

@implementation BSTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.num = 1;
    [self setUpTabBar];
    [self makeNum];
    
    
}


- (void)makeNum
{
    [self setUpTabBar];
    self.selectedIndex = 0;
}

- (void)dealloc
{
    NSLog(@"root tabbar controller dealloc.");
}

#pragma mark - RDVTabBar Delegate

- (BOOL)tabBar:(RDVTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index {
    return [super tabBar:tabBar shouldSelectItemAtIndex:index];
}

- (void)tabBar:(RDVTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index {
    [super tabBar:tabBar didSelectItemAtIndex:index];
}

#pragma mark - UINavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    UIViewController *rootViewController = navigationController.viewControllers.firstObject;
    
    if (viewController != rootViewController) {
        if (self.number == 0) {
            self.tabBar.hidden = YES;
            
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [[[delegate.window.subviews objectAtIndex:0] subviews] objectAtIndex:0].frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            self.number ++;
        }else{
            self.tabBar.hidden = YES;
            
            viewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            navigationController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [[[delegate.window.subviews objectAtIndex:0] subviews] objectAtIndex:0].frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
    } else {
        
        self.tabBar.hidden = NO;
        
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        if (navigationController.viewControllers.count == 1)
        {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    
    UIViewController *rootViewController = navigationController.viewControllers.firstObject;
    
    if (viewController == rootViewController) {
        CGFloat kTabbarHeight = TabBarHeight;
        navigationController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - kTabbarHeight);
        [self.tabBar removeFromSuperview];
        
        self.tabBar.frame = CGRectMake(0, self.view.bounds.size.height - kTabbarHeight, self.view.bounds.size.width, kTabbarHeight);
        
        [self.view addSubview:self.tabBar];
        
    }
    
}

#pragma mark - Override
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _oldSelectedIndex = self.selectedIndex;
    
    [super setSelectedIndex:selectedIndex];
    if (_animated) {
        
        AppDelegate* delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionFade;
        animation.subtype = kCATransitionFromRight;
        
        [delegate.window.layer addAnimation:animation forKey:@"animation"];
        
    }
}

#pragma mark - OrderMode
- (void)setUpTabBar
{
    [self setUpControllers];
    [self setUpModeTabBar];
}

- (void)setUpControllers
{
    //主页
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    
    //走势图页面
    ChartViewController *chartVC = [[ChartViewController alloc] init];
    
    
    //添加所有界面到数组中
    NSMutableArray *mArray = (NSMutableArray *)@[homeVC,chartVC];
    //为每个界面添加导航控制器
    self.viewControllers = [self getNavViewControllersArray:mArray];
}

- (void)setUpModeTabBar
{
    UIImage *finishedImage = [UIImage imageNamed:@"tab_bg"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tab_bg"];
    
    NSArray *tabNamesArray = @[@"历史数据", @"走势图"];
//    NSArray *tabBarItemImages = @[];

    NSInteger index = 0;
    for (RDVTabBarItem *item in [self.tabBar items]) {

//        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
//        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_press",[tabBarItemImages objectAtIndex:index]]];
//        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_n",[tabBarItemImages objectAtIndex:index]]];
//        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        item.unselectedTitleAttributes = @{NSFontAttributeName: GetFont(14), NSForegroundColorAttributeName:RGBCOLORV(0xb6b5b6)};
        item.selectedTitleAttributes = @{NSFontAttributeName: GetFont(14),NSForegroundColorAttributeName:DefaultBackgroundColor};
        
        item.titlePositionAdjustment = UIOffsetMake(0, 3);
        item.title = [tabNamesArray objectAtIndex:index];
        
        item.badgeTextFont = GetFont(10.0f);
        // 气泡颜色值
        item.badgeBackgroundColor = RGBCOLORV(0xF5543C);
        index++;
    }
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -1, SCREEN_WIDTH, 3)];
    lineImageView.image = [UIImage imageNamed:@"bottomLine"];
    [self.tabBar.backgroundView addSubview:lineImageView];
}

#pragma mark - Common Util
- (NSArray *)getNavViewControllersArray:(NSArray *)viewControllers
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:viewControllers.count];
    for (UIViewController *viewController in viewControllers)
    {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        navigationController.navigationBar.translucent = NO;
//        navigationController.navigationBar.barTintColor = TabBarClo;
        navigationController.delegate = self;
        [result addObject:navigationController];
    }
    return result;
}

@end
