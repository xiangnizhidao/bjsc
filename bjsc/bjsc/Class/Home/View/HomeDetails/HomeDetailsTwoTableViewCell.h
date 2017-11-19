//
//  HomeDetailsTwoTableViewCell.h
//  bjsc
//
//  Created by 🍭M on 2017/11/19.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDetailsModel.h"

@interface HomeDetailsTwoTableViewCell : UITableViewCell
//  期数
@property (weak, nonatomic) IBOutlet UILabel *periodsLb;
//  时间
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
//  中奖号码
@property (weak, nonatomic) IBOutlet UILabel *numLb;

- (void)homeDetailsTwoCellWithModel:(HomeDetailsModel *)mod;
@end
