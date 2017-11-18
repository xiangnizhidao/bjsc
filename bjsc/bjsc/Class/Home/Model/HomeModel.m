//
//  HomeModel.m
//  bjsc
//
//  Created by 🍭M on 2017/11/18.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
+ (instancetype)homeWithDict:(NSDictionary *)dict {
    HomeModel *homeM = [[HomeModel alloc] init];
    [homeM setValuesForKeysWithDictionary:dict];
    return homeM;
}
@end
