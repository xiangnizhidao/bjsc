//
//  BSUrl.h
//  ESTicket
//
//  Created by 鹏 刘 on 15/11/25.
//  Copyright © 2015年 鹏 刘. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BSUrl : NSObject

+ (BSUrl*)getInstance;


+ (NSString *)hostUrlWithParam:(NSString *)param;

@end
