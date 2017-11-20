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
#import "NumberView.h"
#import "NumberTableViewCell.h"
#import "ChartViewModel.h"

@interface ChartViewController ()<TypeViewDelegate,UITableViewDelegate,UITableViewDataSource,HeaderViewDelegate>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *image;

@property (nonatomic, strong) TypeView *typeView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, assign) NSInteger headerNumber;

@property (nonatomic, strong) HeaderView *headerView;

@property (nonatomic, assign) NSInteger hearerViewTag;

@property (nonatomic, strong) NSMutableArray *headerArray;

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView = [HeaderView xx_loadFromNibWithOwner:nil];
    self.headerView.delegate = self;
    self.headerView.frame = CGRectMake(0, 0, self.view.frame.size.width,20);
    [self.view addSubview:self.headerView];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, 80, 20);
    [self.button setTitle:@"重庆时时彩" forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(chick) forControlEvents:UIControlEventTouchUpInside];
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(80, 7, 8, 5)];
    self.image.image = [UIImage imageNamed:@"向下箭头"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [view addSubview:self.button];
    [view addSubview:self.image];
    self.navigationItem.titleView = view;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[NumberTableViewCell xx_nib] forCellReuseIdentifier:@"NumberTableViewCell"];
    self.hearerViewTag = 1001;
    self.number = 10;
    self.headerNumber = 5;
}

-(void)viewWillAppear:(BOOL)animated
{
    [LSNetworkService getInformationWithType:@"1" response:^(id dict, BSError *error) {
        self.modelArray = [NSMutableArray array];
        self.headerArray = [NSMutableArray array];
        for (NSDictionary *dic in dict[@"data"]) {
            ChartViewModel *model  = [[ChartViewModel alloc] init];
            model.addtime = dic[@"oc_addtime"];
            model.code = dic[@"oc_code"];
            model.code_detailed = dic[@"oc_code_detailed"];
            model.expect = dic[@"oc_expect"];
            [self.modelArray addObject:model];
            NSArray *array = [model.code componentsSeparatedByString:@","];
            [self.headerArray addObject:array[0]];
        }
        [self.tableView reloadData];
    }];
    
    for (int j = 0; j < 5; j ++) {
        if (j < self.headerNumber) {
            [self.headerView viewWithTag:2001 + j].hidden = NO;
        }else{
            [self.headerView viewWithTag:2001 + j].hidden = YES;
        }
    }
    UIButton *button = (UIButton *)[self.headerView viewWithTag:2001];
    button.backgroundColor = [UIColor redColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

static int i = 0;
-(void)chick
{
    if (i == 0) {
        self.typeView = [TypeView xx_loadFromNibWithOwner:nil];
        self.typeView.frame = CGRectMake(0, 0,self.view.frame.size.width , 130);
        UIButton *button = (UIButton *)[self.typeView viewWithTag:self.hearerViewTag];
        [button setBackgroundColor:[UIColor redColor]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.typeView.delegate = self;
        [self.view addSubview:self.typeView];
        i++;
    }else{
        [self.typeView removeFromSuperview];
        i--;
    }
}

-(void)sendTypeWithString:(NSString *)str name:(NSString *)name
{
    [self.button setTitle:name forState:UIControlStateNormal];
    self.hearerViewTag = 1000 + [str integerValue];
    [self.typeView removeFromSuperview];
    i = 0;
    if ([str integerValue] == 20) {
        self.number = 11;
        self.headerNumber = 5;
    }else if ([str integerValue] == 5 ||[str integerValue] == 6 ||[str integerValue] == 14 ||[str integerValue] == 15 ){
        self.number = 12;
        self.headerNumber = 5;
    }else if ([str integerValue] == 7 ||[str integerValue] == 18){
        self.number = 7;
        self.headerNumber = 3;
    }else if ([str integerValue] == 3 ||[str integerValue] == 4){
        self.number = 10;
        self.headerNumber = 3;
    }else{
        self.number = 10;
        self.headerNumber = 5;
    }
    for (int j = 0; j < 5; j ++) {
        if (j < self.headerNumber) {
            [self.headerView viewWithTag:2001 + j].hidden = NO;
        }else{
            [self.headerView viewWithTag:2001 + j].hidden = YES;
        }
    }
    [LSNetworkService getInformationWithType:str response:^(id dict, BSError *error) {
        self.modelArray = [NSMutableArray array];
        self.headerArray = [NSMutableArray array];
        for (NSDictionary *dic in dict[@"data"]) {
            ChartViewModel *model  = [[ChartViewModel alloc] init];
            model.addtime = dic[@"oc_addtime"];
            model.code = dic[@"oc_code"];
            model.code_detailed = dic[@"oc_code_detailed"];
            model.expect = dic[@"oc_expect"];
            [self.modelArray addObject:model];
            NSArray *array = [model.code componentsSeparatedByString:@","];
            [self.headerArray addObject:array[0]];
        }
        for (int k = 0; k < self.headerNumber; k++) {
            if (0 == k) {
                UIButton *button = (UIButton *)[self.headerView viewWithTag:2000 + k + 1];
                button.backgroundColor = [UIColor redColor];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else{
                UIButton *button = (UIButton *)[self.headerView viewWithTag:2000 + k + 1];
                button.backgroundColor = [UIColor whiteColor];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
        [self.tableView reloadData];
    }];
}

-(void)sendHeaderTypeWithString:(NSString *)str
{
    for (int k = 0; k < self.headerNumber; k++) {
        if ([str integerValue] - 1 == k) {
            UIButton *button = (UIButton *)[self.headerView viewWithTag:2000 + k + 1];
            button.backgroundColor = [UIColor redColor];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            UIButton *button = (UIButton *)[self.headerView viewWithTag:2000 + k + 1];
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    self.headerArray = [NSMutableArray array];
    for (int j = 0; j < self.modelArray.count; j ++) {
        ChartViewModel *model = self.modelArray[j];
        NSArray *array = [model.code componentsSeparatedByString:@","];
        [self.headerArray addObject:array[[str integerValue] - 1]];
    }
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"NumberTableViewCell";
    NumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NumberTableViewCell class])
                                          owner:self
                                        options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ChartViewModel *model = self.modelArray[indexPath.row];
    NSString *Str = [NSString stringWithFormat:@"%@",model.expect];
    cell.numberLabel.text = [Str substringFromIndex:Str.length - 3];
    
    CGFloat width1 = (self.view.frame.size.width - cell.numberLabel.frame.size.width - cell.numberLabel.frame.origin.x) / self.number;
    
    for (int z = 0; z < self.number; z ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(cell.numberLabel.frame.size.width + cell.numberLabel.frame.origin.x + width1 * z, 10, width1, cell.numberLabel.frame.size.height);
        [button setTitle:[NSString stringWithFormat:@"%d",z] forState:UIControlStateNormal];
        if (z == [self.headerArray[indexPath.row] integerValue]) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor redColor];
        }else{
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:13.0];
        button.userInteractionEnabled = NO;
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(cell.numberLabel.frame.size.width + cell.numberLabel.frame.origin.x + width1 * z, 10, 1, cell.numberLabel.frame.size.height)];
        view.backgroundColor = [UIColor grayColor];
        [cell addSubview:button];
        [cell addSubview:view];
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    label.text = @"期数";
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
