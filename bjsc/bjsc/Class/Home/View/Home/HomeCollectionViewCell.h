//
//  HomeCollectionViewCell.h
//  bjsc
//
//  Created by 🍭M on 2017/11/18.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeCollectionViewCell : UICollectionViewCell
// 图标
@property (weak, nonatomic) IBOutlet UIImageView *IMGV;
// 名字
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
// 期数
@property (weak, nonatomic) IBOutlet UILabel *titleLb;

- (void)homeCellWithModel:(HomeModel *)mod;

@end
