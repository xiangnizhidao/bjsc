//
//  TypeView.m
//  bjsc
//
//  Created by 幻想城市ios1 on 2017/11/20.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import "TypeView.h"

@implementation TypeView

- (IBAction)typeChoose:(UIButton *)sender
{
    NSString *str = [NSString stringWithFormat:@"%ld",sender.tag - 1000];
    [self.delegate sendTypeWithString:str];
}


@end
