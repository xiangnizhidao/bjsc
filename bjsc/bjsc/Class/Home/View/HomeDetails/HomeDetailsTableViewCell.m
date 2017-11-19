//
//  HomeDetailsTableViewCell.m
//  bjsc
//
//  Created by 🍭M on 2017/11/18.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import "HomeDetailsTableViewCell.h"

@implementation HomeDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)homeDetailsCellWithName:(NSString *)name {
    self.nameLb.text = name;
}
- (void)homeDetailsCellWithModel:(HomeDetailsModel *)hdcm {
    self.periodsLb.text = [NSString stringWithFormat:@"第%@期",hdcm.oc_expect];
    self.timeLb.text = [self compareTime:hdcm.oc_addtime];
    [self separateNumberLb:hdcm.oc_code];
}

- (void)separateNumberLb:(NSString *)num {
    NSArray *array = [num componentsSeparatedByString:@","];
    for (int i = 0; i < array.count; i++) {
        UIImageView *IV = [[UIImageView alloc] initWithFrame:CGRectMake(28*i, 2, 24, 24)];
        IV.image = [UIImage imageNamed:@"hong"];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(28*i, 0, 24, 24)];
        lb.textColor = [UIColor whiteColor];
        lb.font = [UIFont systemFontOfSize:14.0];
        [lb setTextAlignment:NSTextAlignmentCenter];
        lb.text = [array objectAtIndex:i];
        [self.numV addSubview:IV];
        [self.numV addSubview:lb];
    }
    
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

@end
