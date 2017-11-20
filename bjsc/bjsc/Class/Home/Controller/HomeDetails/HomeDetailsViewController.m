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
#import "LSNetworkService.h"

@interface HomeDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (strong, nonatomic) NSDictionary *dataDic;
@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation HomeDetailsViewController

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

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
    self.navigationItem.title = self.detailsM.name;

    [self.tabV registerNib:[UINib nibWithNibName:@"HomeDetailsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeDetailsTableViewCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"HomeDetailsTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeDetailsTwoTableViewCell"];
    self.tabV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self detailsRequest:self.detailsM.cpKey];
    }];
    [self.tabV.mj_header beginRefreshing];
}

- (void)detailsRequest:(NSString *)keyType {
    [LSNetworkService getRequestHomeDetailsWithType:keyType response:^(id dict, BSError *error) {
        NSLog(@"%@",dict);

        if ([[NSString stringWithFormat:@"%@",dict[@"state"]] isEqualToString:@"1"]) {
            NSArray *arr = dict[@"data"];
            if (self.dataArr != nil && [self.dataArr count] == 0) {
                [self.dataArr removeAllObjects];
            }
            //  遍历
            for (int i = 0; arr.count > i; i++) {
                NSDictionary *Dic = [arr objectAtIndex:i];
                HomeDetailsModel *homeM = [HomeDetailsModel mj_objectWithKeyValues:Dic];
                [self.dataArr addObject:homeM];
            }
            NSLog(@"%@",self.dataArr);
            [self.tabV reloadData];
            [self.tabV.mj_header endRefreshing];
        }else{

        }
    }];

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
    return self.dataArr.count;
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
        HomeDetailsModel *model = [self.dataArr objectAtIndex:0];
        [cell homeDetailsCellWithName:self.detailsM.name];
        [cell homeDetailsCellWithModel:model];
        return cell;
    }else{
        HomeDetailsTwoTableViewCell *twoCell = [self.tabV dequeueReusableCellWithIdentifier:@"HomeDetailsTwoTableViewCell" forIndexPath:indexPath];
        HomeDetailsModel *twomodel = [self.dataArr objectAtIndex:indexPath.row];
        [twoCell homeDetailsTwoCellWithModel:twomodel];
        return twoCell;
        
    }
}




@end
