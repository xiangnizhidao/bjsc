//
//  BSTitleInputTableViewCell.h
//  LotterySelect
//
//  Created by 鹏 刘 on 16/1/7.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSTitleInputTableViewCell;
@protocol BSTitleInputTableViewCellDelegate <NSObject>

- (void)resetTitleInputTableViewCell:(BSTitleInputTableViewCell *)titleInputTableViewCell textFieldValueDidChange:(UITextField *)textField;

@end

@interface BSTitleInputTableViewCell : UITableViewCell

@property (nonatomic, assign) id <BSTitleInputTableViewCellDelegate> delegate;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, copy) void(^textFieldValueDidChange)(UITextField *textField);

@end
