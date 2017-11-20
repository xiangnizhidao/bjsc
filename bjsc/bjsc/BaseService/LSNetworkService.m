//
//  LSNetworkService.m
//  LotterySelect
//
//  Created by 鹏 刘 on 16/5/5.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import "LSNetworkService.h"
#import "BSUrl.h"

@implementation LSNetworkService

+ (void)getInformationWithType:(NSString *)type response:(BSResponse)response
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    long a = [date timeIntervalSince1970] * 1000;
    NSString *str = [NSString stringWithFormat:@"%@key=%@&_=%@",HostUrl,type,@(a)];
    //发送请求
    [BS_HttpService sendGetWithURL:str httpHeader:nil response:^(id dict, BSError *error) {
        response(dict, error);
    }];
}

+ (void)getRequestHomeDetailsWithType:(NSString *)type response:(BSResponse)response {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    long a = [date timeIntervalSince1970] * 1000;
    NSString *str = [NSString stringWithFormat:@"%@key=%@&_=%@",HomeDetailsUrl,type,@(a)];
    //发送请求
    [BS_HttpService sendGetWithURL:str httpHeader:nil response:^(id dict, BSError *error) {
        response(dict, error);
    }];
}


@end
