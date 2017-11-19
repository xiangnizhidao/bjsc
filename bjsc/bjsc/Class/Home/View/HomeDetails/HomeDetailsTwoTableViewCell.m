//
//  HomeDetailsTwoTableViewCell.m
//  bjsc
//
//  Created by 🍭M on 2017/11/19.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import "HomeDetailsTwoTableViewCell.h"

@implementation HomeDetailsTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//  时间格式转换
- (NSString *)compareTime:(NSString *)dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"MM月dd日 HH:mm:ss"];
    NSDate *timeDate = [formatter dateFromString:dateStr];
    NSString *monthStr = [dayFormatter stringFromDate:timeDate];
    return monthStr;
}

- (void)homeDetailsTwoCellWithModel:(HomeDetailsModel *)mod {
    self.periodsLb.text = [NSString stringWithFormat:@"第%@期",mod.oc_expect];
    self.timeLb.text = [self compareTime:mod.oc_addtime];
    self.numLb.text = [mod.oc_code stringByReplacingOccurrencesOfString:@"," withString:@"  "];
}
@end
