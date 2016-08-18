//
//  DrawLineView.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/14.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "DrawLineView.h"

@interface DrawLineView ()

@property (weak, nonatomic)UIView *view;

@end

@implementation DrawLineView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
        
    
        
        CGContextRef context2 = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context2, kCGLineCapRound);
        CGContextSetLineWidth(context2, 1.0);// 宽度
        CGContextSetAllowsAntialiasing(context2, true);
        CGContextSetRGBStrokeColor(context2, 88.0/255.0, 163.0/255.0, 130.0/255.0, 1.0);//
        CGContextBeginPath(context2);
        CGContextMoveToPoint(context2, 0, [UIScreen mainScreen].bounds.size.height/4 + kScreenWidth/37.7*2-2);// 起点
        CGContextAddLineToPoint(context2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/4 + kScreenWidth/37.7*2-2);// 终点
        CGContextStrokePath(context2);
   
//
//
//        CGContextRef context1 = UIGraphicsGetCurrentContext();
//        CGContextSetLineCap(context1, kCGLineCapRound);
//        CGContextSetLineWidth(context1, 1.5);// 宽度
//        CGContextSetAllowsAntialiasing(context1, true);
//        CGContextSetRGBStrokeColor(context1, 252.0/255.0, 207.0/255.0, 124.0/255.0, 1.0);//
//        CGContextBeginPath(context1);
//        CGContextMoveToPoint(context1, 30, 30);
//        CGContextAddLineToPoint(context1, 40, 40);
//        CGContextStrokePath(context1);
    
    //    折线1
    UIBezierPath *linePath1 = [UIBezierPath bezierPath];
    [linePath1 moveToPoint:CGPointMake(0, 0)];// 起点
    for (int i = 0; i < 3; i++) {
        [linePath1 addLineToPoint:CGPointMake(0, 0)];// 添加点数
    }
    
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = linePath1.CGPath;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    
    //   折线2
    UIBezierPath *linePath2 = [UIBezierPath bezierPath];
    [linePath2 moveToPoint:CGPointMake(0, 0)];// 起点
    for (int i = 0; i < 3; i++) {
        [linePath2 addLineToPoint:CGPointMake(0, 0)];// 添加点数
    }
    CAShapeLayer *layer2 = [[CAShapeLayer alloc]init];
    layer2.path = linePath2.CGPath;
    layer2.strokeColor = [UIColor redColor].CGColor;
    layer2.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:layer2];
    
    
    
}


@end
