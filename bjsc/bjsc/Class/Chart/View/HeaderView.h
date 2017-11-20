//
//  HeaderView.h
//  bjsc
//
//  Created by 付莉 on 2017/11/19.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate <NSObject>

-(void)sendHeaderTypeWithString:(NSString *)str;

@end

@interface HeaderView : UIView

@property (nonatomic, weak) id <HeaderViewDelegate> delegate;

@end
