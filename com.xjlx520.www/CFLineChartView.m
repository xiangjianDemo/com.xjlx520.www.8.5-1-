//
//  CFLineChartView.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/15.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "CFLineChartView.h"

static CGRect myFrame;
static int count;// 点个数，x轴格子数

#define kMargin 30


@interface CFLineChartView ()
@property(weak,nonatomic)UIView *bgView;
@end


@implementation CFLineChartView



+ (instancetype)lineChartViewWithFrame:(CGRect)frame{
    CFLineChartView *lineChartView = [[NSBundle mainBundle]loadNibNamed:@"CFLineChartView" owner:self options:nil].lastObject;
    lineChartView.frame = frame;
    
    myFrame = frame;
    
    return lineChartView;
}

#pragma mark ---计算－－－
- (void)deWithCalculate{
    if (!self.xValues || !self.xValues.count || !self.yVAlues || !self.yVAlues.count) {
        return;
    }
//    移除多余的值
    if (self.xValues.count > self.yVAlues.count) {
        NSMutableArray *xArr = [self.xValues mutableCopy];
        for (int i = 0; i < self.yVAlues.count - self.xValues.count; i++) {
            [xArr removeAllObjects];
        }
        self.xValues = [xArr mutableCopy];
    }else if(self.xValues.count > self.yVAlues.count){
        NSMutableArray *yArr = [self.yVAlues mutableCopy];
        for (int i = 0; i < self.yVAlues.count - self.xValues.count; i++) {
            [yArr removeAllObjects];
        }
        self.yVAlues = [yArr mutableCopy];
    }
    count = (int)self.xValues.count;
    
    
}
#pragma mark---画点---
-(void)drawPointsWithPointType:(PointType)pointType{
    for (int i = 0; i < count; i++) {
        CGPoint point = CGPointMake(0, 0);
        CAShapeLayer *layer = [[CAShapeLayer alloc]init];
        layer.frame = CGRectMake(point.x-2.5, point.y - 20.5, 5, 5);
        layer.backgroundColor = [UIColor redColor].CGColor;
        [self.bgView.layer addSublayer:layer];
    }
    
}
#pragma mark---画折线---
- (void)drawFoldLineWithChartType:(LineChartType)type{
//    折线1
    UIBezierPath *linePath1 = [UIBezierPath bezierPath];
    [linePath1 moveToPoint:CGPointMake(0, 0)];// 起点
    for (int i = 0; i < count; i++) {
        [linePath1 addLineToPoint:CGPointMake(30*i, 30*i)];// 添加点数
    }
    
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = linePath1.CGPath;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.bgView.layer addSublayer:layer];
    
//   折线2
    UIBezierPath *linePath2 = [UIBezierPath bezierPath];
    [linePath2 moveToPoint:CGPointMake(0, 80)];
    for (int i = 0; i < count; i++) {
        [linePath2 addLineToPoint:CGPointMake(30*i, 30*i)];
    }
    CAShapeLayer *layer2 = [[CAShapeLayer alloc]init];
    layer2.path = linePath2.CGPath;
    layer2.strokeColor = [UIColor redColor].CGColor;
    layer2.fillColor = [UIColor clearColor].CGColor;
    [self.bgView.layer addSublayer:layer2];
    
    
}

-(void)drawChartWithLineChartType:(LineChartType)lineType pointType:(PointType)pointType{
    
}

@end
