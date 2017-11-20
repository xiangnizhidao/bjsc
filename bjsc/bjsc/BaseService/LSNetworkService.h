//
//  LSNetworkService.h
//  LotterySelect
//
//  Created by 鹏 刘 on 16/5/5.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG

//测试
#define HostUrl @"http://tt.76yule.com/ajax/openCode.ashx?action=2&callback=jQuery21409526351092121202_1511143969105&"
#define HomeDetailsUrl @"http://tt.76yule.com/ajax/openCode.ashx?action=4&callback=jQuery21409593054468277842_1511157075798&"
#define firstURL @"http://103.24.94.32:8080/biz/getAppConfig?appid="
#else
//发布
#define HostUrl @"http://tt.76yule.com/ajax/openCode.ashx?action=2&callback=jQuery21409526351092121202_1511143969105&"
#define HomeDetailsUrl @"http://tt.76yule.com/ajax/openCode.ashx?action=4&callback=jQuery21409593054468277842_1511157075798&"
#define firstURL @"http://103.24.94.32:8080/biz/getAppConfig?appid="
#endif

@interface LSNetworkService : NSObject

+ (void)getInformationWithType:(NSString *)type response:(BSResponse)response;
//  主页请求
+ (void)getRequestHomeDetailsWithType:(NSString *)type response:(BSResponse)response;

+ (void)getFirstUrlresponse:(BSResponse)response;
@end
