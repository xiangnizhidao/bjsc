//
//  ChartViewController.m
//  bjsc
//
//  Created by 付莉 on 2017/11/19.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import "ChartViewController.h"
#import "HeaderView.h"
#import "TypeView.h"

@interface ChartViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *image;

@property (nonatomic, strong) TypeView *typeView;

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HeaderView *headerView = [HeaderView xx_loadFromNibWithOwner:nil];
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    [self.view addSubview:headerView];
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.frame = CGRectMake(0, 0, 80, 20);
    [self.button setTitle:@"走势图" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(chick) forControlEvents:UIControlEventTouchUpInside];
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(80, 7, 8, 5)];
    self.image.image = [UIImage imageNamed:@"向下箭头"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [view addSubview:self.button];
    [view addSubview:self.image];
    self.navigationItem.titleView = view;
}

static int i = 0;
-(void)chick
{
    if (i == 0) {
        self.typeView = [TypeView xx_loadFromNibWithOwner:nil];
        self.typeView.frame = CGRectMake(0, 0,self.view.frame.size.width , 130);
        [self.view addSubview:self.typeView];
        i++;
    }else{
        [self.typeView removeFromSuperview];
        i--;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
