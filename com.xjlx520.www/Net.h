//
//  Net.h
//  享见1.0
//
//  Created by 勇 舒 on 16/7/21.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

// 代理
@protocol NetDelegate <NSObject>

// 代理回调的方法
- (void)getWeatherInfoSuccessFeedback:(id)feedbackInfo;
- (void)getWeatherInfoFailFeedback:(id)failInfo;

// 滚动视图回调方法
- (void)getWeatherInfoSuccessRoll:(id)roll;
- (void)getWeatherInfoFailRoll:(id)roll;

// 分类广告明细回调方法
- (void)getWeatherInfoSuccessClassMingxi:(id)Mingxi;
- (void)getWeatherInfoFailClassMingxi:(id)Mingxi;

// 广告分页回调方法
- (void)getWeatherInfoSuccessClassPage:(id)page;
- (void)getWeatherInfoFailClassPage:(id)page;

@end

@interface Net : NSObject

// 声明代理
@property (nonatomic, strong) id<NetDelegate>delegate;


/*
 获取城市名
 */
- (void)getWeatherInfoWithCity:(NSString *)cityName;

// 分类广告
- (void)getWeatherInfoWithClassifiedAds:(NSString *)classAds;
// 滚动广告
- (void)getWeatherInfoWithRollAds:(NSString *)rollAds;
//广告明细
- (void)getWeatherInfoWithAdsMingXi:(NSString *)Mingxi;

// 推送广告
- (void)getWeatherInfoPushWithAdsPage:(NSString *)page;

/*
 获取Net类的单例
 */
+(Net *)getInstance;

@end
