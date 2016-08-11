//
//  Net.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/21.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "Net.h"
#import "TheAFNetWorking.h"
__strong static AFHTTPSessionManager  *AFHTTPMgr;
__strong static Net *NetInstance = nil;

@implementation Net

+ (Net *)getInstance{
//     单例Net类
    static dispatch_once_t onceToken;
//    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NetInstance = [[Net alloc]init];//初始化实例
//        AFHTTPRequestOperationManager的配置
        AFHTTPMgr = [AFHTTPSessionManager  manager];
//        申请返回的结果是json类型
        AFHTTPMgr.responseSerializer = [AFJSONResponseSerializer serializer];
//        申请请求的数据时json类型
        AFHTTPMgr.requestSerializer = [AFJSONRequestSerializer serializer];
        
//        设置超时 时间
        AFHTTPMgr.requestSerializer.timeoutInterval = 5;
    });
    
    return NetInstance;
}

// 请求城市名
- (void)getWeatherInfoWithCity:(NSString *)cityName{
//    接口地址
    NSString *url = [NSString stringWithFormat:@"接口"];
//    参数
    NSDictionary *parameters = [[NSDictionary alloc]initWithObjectsAndKeys:@"", nil];

[AFHTTPMgr POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
}];
}


// 分类广告请求
- (void)getWeatherInfoWithClassifiedAds:(NSString *)classAds{
    //    接口地址
//    NSString *url = [NSString stringWithFormat:@"http://219.151.12.30:8081/admin/webapi/Handler_advertisement_fenl.ashx"];
//    NSString *url = [NSString stringWithFormat:@"%@/admin/webapi/Handler_advertisement_fenl.ashx?flag=advertisement_fenl_query",[TheAFNetWorking ]];
    NSString *url =[TheAFNetWorking httpURLStr:@"/admin/webapi/Handler_advertisement_fenl.ashx?flag=advertisement_fenl_query"];
   
    //    参数
    NSDictionary *parameters = [[NSDictionary alloc]initWithObjectsAndKeys:classAds,@"flag", nil];
    //    发请求
    

    
//    [AFHTTPMgr POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [self.delegate getWeatherInfoSuccessFeedback:responseObject];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self.delegate getWeatherInfoFailFeedback:error];
//    }];
    [TheAFNetWorking postHttpsURL:url parameters:parameters AndSuccess:^(NSArray *dic) {
        
        
        NSLog(@"%@",dic);
        
        
        [self.delegate getWeatherInfoSuccessFeedback:dic];
    } orfailure:^{
        [self.delegate getWeatherInfoFailFeedback:nil];
    } showHUD:NO];

}
// 滚动广告请求
- (void)getWeatherInfoWithRollAds:(NSString *)rollAds{
//    接口地址
//    NSString *url = [NSString stringWithFormat:@"http://219.151.12.30:8081/admin/webapi/Handler_tb_advertisement.ashx"];
   
    NSDictionary *parameters = [[NSDictionary alloc]initWithObjectsAndKeys:rollAds,@"flag", nil];
    
     
  

}

// 广告明细
- (void)getWeatherInfoWithAdsMingXi:(NSString *)Mingxi{
    NSString *url = [NSString stringWithFormat:@"http://219.151.12.30:8081/admin/webapi/Handlerlx_guanggao.ashx?flag=tb_lx_guanggao_show&lx_id=1"];
    NSDictionary *parmeters = [[NSDictionary alloc]initWithObjectsAndKeys:@"", nil];

    [AFHTTPMgr POST:url parameters:parmeters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          [self.delegate getWeatherInfoFailRoll:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       [self.delegate getWeatherInfoFailRoll:error];
    }];
}


// 推送广告
- (void)getWeatherInfoPushWithAdsPage:(NSString *)page{
    NSString *url = [NSString stringWithFormat:@"http://219.151.12.30:8081/admin/webapi/Handlerlx_guanggao.ashx"];
//    NSDictionary *parmeters = [[NSDictionary alloc]initWithObjectsAndKeys:@"flag", nil];
    NSDictionary *parmeters = @{@"flag":page,@"useraihao":@"7",@"userage":@"30",@"usersex":@"1",@"usermoney":@"1200",@"pags":@"1",@"page":@"1"};

    
    [AFHTTPMgr GET:url parameters:parmeters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.delegate getWeatherInfoSuccessRoll:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.delegate getWeatherInfoFailRoll:error];
    }];
    
    
}


@end
