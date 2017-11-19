//
//  HomeDetailsViewController.m
//  bjsc
//
//  Created by 🍭M on 2017/11/18.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import "HomeDetailsViewController.h"
#import "HomeDetailsTableViewCell.h"
#import "HomeDetailsTwoTableViewCell.h"

@interface HomeDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (strong, nonatomic) NSDictionary *dataDic;
@end

@implementation HomeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataDic = @{@"oc_expect":@"2017314",@"oc_code":@"5,28,0,34,43,2,3,23,2,7",@"oc_addtime":@"2017-11-17 20:41:03"};
    [self creatTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatTableView {
    self.navigationItem.title = self.detailsM.name;

    [self.tabV registerNib:[UINib nibWithNibName:@"HomeDetailsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeDetailsTableViewCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"HomeDetailsTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeDetailsTwoTableViewCell"];
    self.tabV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self detailsRequest];
    }];
    [self.tabV.mj_header beginRefreshing];
}

- (void)detailsRequest {
    
    [self.tabV.mj_header endRefreshing];
}


#pragma mark----UItableView

//  分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//  行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80;
    }
    return 60;
}

//  返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

//  尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    footV.backgroundColor = [UIColor clearColor];
    UILabel *la = [[UILabel alloc ]init ];
    la.frame = CGRectMake(20, 12, SCREEN_WIDTH-40 , 20);
    la.text = @"-------我是有底线的-------";
    la.textColor = [UIColor lightGrayColor];
    la.font = [UIFont systemFontOfSize:10.0];
    la.textAlignment = NSTextAlignmentCenter;
    [footV addSubview:la];
    return footV;
}
//  头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}


// cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        HomeDetailsTableViewCell *cell = [self.tabV dequeueReusableCellWithIdentifier:@"HomeDetailsTableViewCell" forIndexPath:indexPath];
        HomeDetailsModel *model = [HomeDetailsModel mj_objectWithKeyValues:self.dataDic];
        [cell homeDetailsCellWithName:self.detailsM.name];
        [cell homeDetailsCellWithModel:model];
        return cell;
    }
    HomeDetailsTwoTableViewCell *twoCell = [self.tabV dequeueReusableCellWithIdentifier:@"HomeDetailsTwoTableViewCell" forIndexPath:indexPath];
    HomeDetailsModel *twomodel = [HomeDetailsModel mj_objectWithKeyValues:self.dataDic];
    [twoCell homeDetailsTwoCellWithModel:twomodel];
    return twoCell;
}




@end
