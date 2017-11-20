//
//  PrecentCricleView.m
//  LotterySelect
//
//  Created by 牛方路 on 16/8/30.
//  Copyright © 2016年 鹏 刘. All rights reserved.
//

#import "PrecentCricleView.h"

@interface PrecentCricleView ()
{
    
    CAShapeLayer *backGroundLayer; //背景图层
    CAShapeLayer *frontFillLayer;      //用来填充的图层
    UIBezierPath *backGroundBezierPath; //背景贝赛尔曲线
    UIBezierPath *frontFillBezierPath;  //用来填充的贝赛尔曲线
    
}
@end

@implementation PrecentCricleView

@synthesize progressColor = _progressColor;
@synthesize progressTrackColor = _progressTrackColor;
@synthesize progressValue = _progressValue;
@synthesize progressStrokeWidth = _progressStrokeWidth;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUp];
        
    }
    return self;
    
}
/**
 *  初始化创建图层
 */
- (void)setUp
{
    //创建背景图层
    backGroundLayer = [CAShapeLayer layer];
    backGroundLayer.fillColor = nil;
    backGroundLayer.frame = self.bounds;
    
    //创建填充图层
    frontFillLayer = [CAShapeLayer layer];
    frontFillLayer.fillColor = nil;
    frontFillLayer.frame = self.bounds;
    
    
    [self.layer addSublayer:backGroundLayer];
    [self.layer addSublayer:frontFillLayer];
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    frontFillLayer.strokeColor = progressColor.CGColor;
}
- (UIColor *)progressColor
{
    return _progressColor;
}
//设置背景环的位置
- (void)setProgressTrackColor:(UIColor *)progressTrackColor
{
    _progressTrackColor = progressTrackColor;
    backGroundLayer.strokeColor = progressTrackColor.CGColor;
    backGroundBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:(CGRectGetWidth(self.bounds)-self.progressStrokeWidth)/2.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    backGroundLayer.path = backGroundBezierPath.CGPath;
}
- (UIColor *)progressTrackColor
{
    return _progressTrackColor;
}

//设置填充层的颜色和角度值
- (void)setProgressValue:(CGFloat)progressValue
{
    _progressValue = progressValue;
    frontFillBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:(CGRectGetWidth(self.bounds)-self.progressStrokeWidth)/2.f startAngle:3*M_PI/2 endAngle:(2*M_PI)*progressValue+3*M_PI/2 clockwise:YES];
    frontFillLayer.path = frontFillBezierPath.CGPath;
}
- (CGFloat)progressValue
{
    return _progressValue;
}
- (void)setProgressStrokeWidth:(CGFloat)progressStrokeWidth
{
    _progressStrokeWidth = progressStrokeWidth;
    frontFillLayer.lineWidth = progressStrokeWidth;
    backGroundLayer.lineWidth = progressStrokeWidth;
}
- (CGFloat)progressStrokeWidth
{
    return _progressStrokeWidth;
}



@end
