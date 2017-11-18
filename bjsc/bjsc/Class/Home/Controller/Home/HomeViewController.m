//
//  HomeViewController.m
//  bjsc
//
//  Created by 🍭M on 2017/11/18.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import "HomeViewController.h"
//  自定义cell
#import "HomeCollectionViewCell.h"
//  详情页
#import "HomeDetailsViewController.h"
//  模型
#import "HomeModel.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectV;
@property (strong, nonatomic) NSArray *dataArr;
@end

@implementation HomeViewController

- (NSArray *)dataArr {
    if (_dataArr == nil) {
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"homeData.plist" ofType:nil]];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            [arrM addObject:[HomeModel homeWithDict:dict]];
        }
        _dataArr = arrM;
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatCollection];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatCollection {
    //布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((SCREEN_WIDTH - 2) / 3, 160)];
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing = 1;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.collectV setCollectionViewLayout:flowLayout];
    [self.collectV registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];

}

#pragma mark ------ collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = [self.collectV dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    HomeModel *appM = [self.dataArr objectAtIndex:indexPath.row];
    [cell homeCellWithModel:appM];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeDetailsViewController *hdvc = [[HomeDetailsViewController alloc] init];
    hdvc.detailsM = [self.dataArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:hdvc animated:YES];
    
}

@end
