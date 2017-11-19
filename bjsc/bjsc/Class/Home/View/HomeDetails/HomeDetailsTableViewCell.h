//
//  HomeDetailsTableViewCell.h
//  bjsc
//
//  Created by 🍭M on 2017/11/18.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDetailsModel.h"

@interface HomeDetailsTableViewCell : UITableViewCell
//  名字
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
//  期数
@property (weak, nonatomic) IBOutlet UILabel *periodsLb;
//  时间
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
//  开奖号码View
@property (weak, nonatomic) IBOutlet UIView *numV;

- (void)homeDetailsCellWithName:(NSString *)name;
- (void)homeDetailsCellWithModel:(HomeDetailsModel *)hdcm;

@end
