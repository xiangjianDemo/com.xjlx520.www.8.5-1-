//
//  Net1.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/25.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "Net1.h"
__strong static AFHTTPSessionManager *AFHTTPMgr;
__strong static Net1 *NetInstance = nil;

@implementation Net1

+ (Net1 *)getInstance{
    
    //     单例Net类
    static dispatch_once_t onceToken;
    //    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NetInstance = [[Net1 alloc]init];//初始化实例
        //        AFHTTPRequestOperationManager的配置
        AFHTTPMgr = [AFHTTPSessionManager manager];
        //        申请返回的结果是json类型
        AFHTTPMgr.responseSerializer = [AFJSONResponseSerializer serializer];
        //        申请请求的数据时json类型
        AFHTTPMgr.requestSerializer = [AFJSONRequestSerializer serializer];
        
        //        设置超时 时间
        AFHTTPMgr.requestSerializer.timeoutInterval = 5;
        
    });
    
    return NetInstance;
}

// 滚动广告请求
- (void)getWeatherInfoWithRollAds:(NSString *)rollAds1{
    //    接口地址
    NSString *url = [NSString stringWithFormat:@"http://219.151.12.30:8081/admin/webapi/Handler_tb_advertisement.ashx"];
    NSDictionary *parameters = [[NSDictionary alloc]initWithObjectsAndKeys:rollAds1,@"flag", nil];
    [AFHTTPMgr POST:url parameters:parameters  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.delegate getWeatherInfoSuccessRoll:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self.delegate getWeatherInfoFailRoll:error];
    }];
}

@end
