//
//  HomeDetailsModel.h
//  bjsc
//
//  Created by 🍭M on 2017/11/19.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeDetailsModel : NSObject
/*** 期数 ***/
@property (copy, nonatomic) NSString *oc_expect;
/*** 中奖号码 ***/
@property (copy, nonatomic) NSString *oc_code;
/*** 数据更新时间 ***/
@property (copy, nonatomic) NSString *oc_addtime;


@end
