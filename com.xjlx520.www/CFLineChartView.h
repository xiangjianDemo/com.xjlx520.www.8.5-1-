//
//  CFLineChartView.h
//  享见1.0
//
//  Created by 勇 舒 on 16/7/15.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import <UIKit/UIKit.h>
// 线条类型
typedef NS_ENUM(NSInteger,LineChartType) {
     LineChartType_Straight, // 折线1
    LineChartType_Straight1 //折线2
};
// 点类型
typedef NS_ENUM(NSInteger,PointType) {
    PointType_Circel // 圆形
};
@interface CFLineChartView : UIView
// x轴
@property (nonatomic, copy)NSArray *xValues;
// y轴
@property (nonatomic ,copy)NSArray *yVAlues;
// 是否显示点
@property (nonatomic ,assign)bool isShowPoint;

// 初始化折现图 所在视图
+(instancetype)lineChartViewWithFrame:(CGRect)frame;

// 绘制折线图
-(void)drawChartWithLineChartType:(LineChartType)lineType pointType:(PointType)pointType;
@end
