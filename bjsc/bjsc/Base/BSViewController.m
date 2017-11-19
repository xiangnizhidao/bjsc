//
//  BSViewController.m
//  LotterySelect
//
//  Created by 鹏 刘 on 15/11/23.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import "BSViewController.h"

@interface BSViewController ()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BSViewController

- (void)dealloc
{
    NSLog(@"");
    @try{
        [[NSNotificationCenter defaultCenter]removeObserver:self];//移除通知
    } @catch(id anException) {
        //do nothing, obviously it wasn't attached because an exception was thrown
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.view.backgroundColor = DefaultBackgroundColor;
//    self.navigationItem.titleView = self.titleView;

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* 创建一个String导航按钮 */
- (UIBarButtonItem *)createStringNavBarItem:(NSString *)title
                                  textColor:(UIColor *)textColor
                                     action:(SEL)action {
    UIButton *button = [self createStringButton:title
                                      textColor:textColor
                                         action:action];
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barbutton;
}

- (UIButton *)createStringButton:(NSString *)title
                       textColor:(UIColor *)textColor
                          action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = GetFont(17);
    button.titleLabel.textColor = textColor;
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    CGSize textSize = [title sizeWithFont:button.titleLabel.font];
    CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName : [button.titleLabel font]}];
    button.frame = CGRectMake(0, 0, textSize.width, 30.0f);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/* 创建一个图片导航按钮 */
- (UIBarButtonItem *)createImageNavBarItem:(NSString *)normalImageName
                              withHightImg:(NSString *)heightedImageName
                                    action:(SEL)action {
    
    UIButton *button = [self createImageButton:normalImageName
                                  hightedImage:heightedImageName
                                        action:action];
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barbutton;
}

- (UIButton *)createTextButton:(NSString *)text action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 30.0f);
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font = GetFont(15.0f);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIButton *)createImageButton:(NSString *)normalImageName
                   hightedImage:(NSString *)heightedImageName
                         action:(SEL)action {
    
    UIImage *barButtonImage = GetImage(normalImageName);
    UIImage *barButtonHighlightImage = GetImage(heightedImageName);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 35, 30.0f);
    [button setImage:barButtonImage forState:UIControlStateNormal];
    [button setImage:barButtonHighlightImage forState:UIControlStateHighlighted];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 35 - barButtonImage.size.width, 0, 0)];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (UIBarButtonItem *)createBackImageNavBarItem:(NSString *)normalImageName
                                  withHightImg:(NSString *)heightedImageName
                                        action:(SEL)action {
    UIButton *button = [self createBackImageButton:normalImageName
                                      hightedImage:heightedImageName
                                            action:action];
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barbutton;
}

- (UIButton *)createBackImageButton:(NSString *)normalImageName
                       hightedImage:(NSString *)heightedImageName
                             action:(SEL)action {
    UIImage *barButtonImage = GetImage(normalImageName);
    UIImage *barButtonHighlightImage = GetImage(heightedImageName);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 35, 30.0f);
    [button setImage:barButtonImage forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35-barButtonImage.size.width)];
    [button setImage:barButtonHighlightImage forState:UIControlStateHighlighted];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/* 填加返回按钮 */
- (void)addNavBarBackButton {
    if ([self.navigationController.navigationBar isKindOfClass:[UINavigationBar class]] &&
        self.navigationController.viewControllers &&
        [self.navigationController.viewControllers count] > 1) {
        NSLog(@"%ld",[self.navigationController.viewControllers count]);
        self.leftBarButtonItem = [self createBackImageNavBarItem:@"nav_icon_return" withHightImg:@"nav_icon_return" action:@selector(back:)];
    }
}

- (void)addGotoHomeButton{
    if ([self.navigationController.navigationBar isKindOfClass:[UINavigationBar class]] &&
        self.navigationController.viewControllers &&
        [self.navigationController.viewControllers count] > 2 &&
        !self.navigationItem.rightBarButtonItem) {
        self.rightBarButtonItem = [self createImageNavBarItem:@"home page" withHightImg:@"home page" action:@selector(gotoHome)];
    }
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = 0;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, barButtonItem, nil];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = 0;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, barButtonItem, nil];
}

- (UIBarButtonItem *)leftBarButtonItem
{
    if (self.navigationItem.leftBarButtonItems != nil && self.navigationItem.leftBarButtonItems.count == 0)
    {
        return nil;
    }
    
    return self.navigationItem.leftBarButtonItems.lastObject;
}

- (UIBarButtonItem *)rightBarButtonItem
{
    if (self.navigationItem.rightBarButtonItem != nil && self.navigationItem.rightBarButtonItems.count == 0)
    {
        return nil;
    }
    
    return self.navigationItem.rightBarButtonItems.lastObject;
}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    
    [self.navigationItem setTitleView:self.titleView];
    self.titleLabel.text = title;
}

- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 200, 30)];
        self.titleLabel = [[UILabel alloc] init];
        [_titleView addSubview:self.titleLabel];
        _titleLabel.textColor = [UIColor whiteColor];//[UIColor blackColor];
        _titleLabel.font = GetFont(18.0f);
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_titleView);
            make.width.lessThanOrEqualTo(@(SCREEN_WIDTH - 80));
        }];
    }
    return _titleView;
    
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

+ (instancetype)viewController {
    BSViewController *viewController = [[BSViewController alloc] init];
    return viewController;
}

@end
