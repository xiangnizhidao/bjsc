//
//  HomeDetailsViewController.m
//  bjsc
//
//  Created by 🍭M on 2017/11/18.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import "HomeDetailsViewController.h"
#import "HomeDetailsTableViewCell.h"


@interface HomeDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tabV;

@end

@implementation HomeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatTableView {
     [self.tabV registerNib:[UINib nibWithNibName:@"HomeDetailsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeDetailsTableViewCell"];
    
}

#pragma mark----UItableView

//  分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//  行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

//  返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

//  尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

//  头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}


// cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeDetailsTableViewCell *cell = [self.tabV dequeueReusableCellWithIdentifier:@"HomeDetailsTableViewCell" forIndexPath:indexPath];
    return cell;
}

// 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
