//
//  HomeCollectionViewCell.m
//  bjsc
//
//  Created by 🍭M on 2017/11/18.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)homeCellWithModel:(HomeModel *)mod {
    self.nameLb.text = mod.name;
    self.IMGV.image = [UIImage imageNamed:mod.cpimg];
    self.titleLb.text = mod.title;
}
@end
