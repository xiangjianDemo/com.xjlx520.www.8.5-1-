//
//  Net1.h
//  享见1.0
//
//  Created by 勇 舒 on 16/7/25.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
// 代理
@protocol Netdetegate <NSObject>

// 滚动视图回调方法
- (void)getWeatherInfoSuccessRoll:(id)roll1;
- (void)getWeatherInfoFailRoll:(id)roll1;

@end

@interface Net1 : NSObject

// 声明代理
@property (nonatomic, strong) id<Netdetegate>delegate;

// 滚动广告
- (void)getWeatherInfoWithRollAds:(NSString *)rollAds1;
/*
 获取Net类的单例
 */
+(Net1 *)getInstance;

@end
