//
//  DrowLineThreeView.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/18.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "DrowLineThreeView.h"

@implementation DrowLineThreeView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1.5);// 宽度
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 88.0/255.0, 163.0/255.0, 130.0/255.0, 1.0);// 颜色
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, [UIScreen mainScreen].bounds.size.height/10-5);// 起点
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height/10-5 );// 终点
    CGContextStrokePath(context);
}


@end
