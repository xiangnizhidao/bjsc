//
//  TypeView.h
//  bjsc
//
//  Created by 幻想城市ios1 on 2017/11/20.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeViewDelegate <NSObject>

-(void)sendTypeWithString:(NSString *)str name:(NSString *)name;

@end

@interface TypeView : UIView

@property (nonatomic, weak) id <TypeViewDelegate> delegate;

@end
