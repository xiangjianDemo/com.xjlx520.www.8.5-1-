//
//  DrawLineTowView.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/14.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "DrawLineTowView.h"


@implementation DrawLineTowView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (int i = 0; i < 2; i++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, 1.5);// 宽度
        CGContextSetAllowsAntialiasing(context, true);
        CGContextSetRGBStrokeColor(context, 88.0/255.0, 163.0/255.0, 130.0/255.0, 1.0);// 颜色
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, 10 +35*i);// 起点
        CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width, 10 +35*i);// 终点
        CGContextStrokePath(context);
    }
   
}


@end
