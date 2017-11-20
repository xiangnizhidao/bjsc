//
//  HeaderView.m
//  bjsc
//
//  Created by 付莉 on 2017/11/19.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (IBAction)headerType:(UIButton *)sender {
    [self.delegate sendHeaderTypeWithString:[NSString stringWithFormat:@"%ld",sender.tag - 2000]];
}


@end
