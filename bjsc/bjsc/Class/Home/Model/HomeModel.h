//
//  HomeModel.h
//  bjsc
//
//  Created by 🍭M on 2017/11/18.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

// 名字
@property (copy, nonatomic) NSString *name;
// 期数
@property (copy, nonatomic) NSString *title;
/*** key ***/
@property (copy, nonatomic) NSString *cpKey;
/*** 图片 ***/
@property (copy, nonatomic) NSString *cpimg;

+ (instancetype)homeWithDict:(NSDictionary *)dict;

@end
