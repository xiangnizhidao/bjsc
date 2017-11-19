//
//  ChartViewController.m
//  bjsc
//
//  Created by 付莉 on 2017/11/19.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import "ChartViewController.h"
#import "HeaderView.h"

@interface ChartViewController ()

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    HeaderView *headerView = [HeaderView xx_loadFromNibWithOwner:nil];
    headerView.frame = CGRectMake(0, 10, self.view.frame.size.width, 40);
    [self.view addSubview:headerView];
    self.title = @"走势图";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
