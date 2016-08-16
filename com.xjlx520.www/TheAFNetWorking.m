//
//  TheAFNetWorking.m
//  com.xjlx520.www
//
//  Created by 勇 舒 on 16/8/8.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "TheAFNetWorking.h"

@implementation TheAFNetWorking
+(instancetype)sharedInstance{
    static TheAFNetWorking *_manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[super alloc]init];
    });
    return _manager;

}
+(NSString *)httpURLStr:(NSString *)url{
    NSString *urlStr  =[NSString stringWithFormat:@"http://219.151.12.30:8081/%@",url];
    return urlStr;
}
+(void)postHttpsURL:(NSString *)url parameters:(NSDictionary *)parameter AndSuccess:(void(^)(NSArray *dic))dic orfailure:(void(^)())isfailure showHUD:(BOOL)show{
     UIView *view = (UIView*)[[[UIApplication sharedApplication]delegate]window];
    MBProgressHUD *hud;
    if (show==YES) {
        hud = [[MBProgressHUD alloc]initWithView:view];
          hud.label.text = @"加载中";
        @try {
             [view addSubview:hud];
        } @catch (NSException *exception) {
            
        }
       
        [hud showAnimated:YES];
    }
   
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", nil];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.f;
    NSLog(@"%@",url);
    
    
    
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *responseObject) {
        NSLog(@"asssssss");
        
        
        if (dic) {
            dic(responseObject);
            [hud hideAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        
        if (isfailure) {
            MBProgressHUD *errorHUD = [[MBProgressHUD alloc]initWithView:view];
            errorHUD.label.text =  @"数据请求失败";
            errorHUD.mode = MBProgressHUDModeText;
            [view addSubview:errorHUD];
             [errorHUD showAnimated:YES];
            [errorHUD hideAnimated:YES afterDelay:2.5];
            NSLog(@"aaasdsadasdas");
            isfailure();
            [hud hideAnimated:YES];
        }
    }];
}
+(void)getHttpsURL:(NSString *)url parameters:(NSDictionary *)parameter AndSuccess:(void(^)(NSArray *dic))dic orfailure:(void(^)())isfailure showHUD:(BOOL)show{
    UIView *view = (UIView*)[[[UIApplication sharedApplication]delegate]window];
    MBProgressHUD *hud;
    if (show==YES) {
        hud = [[MBProgressHUD alloc]initWithView:view];
        hud.label.text = @"加载中";
        [view addSubview:hud];
        [hud showAnimated:YES];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", nil];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.f;
    NSLog(@"%@",url);
[manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSArray *responseObject) {
    if (dic) {
        dic(responseObject);
        [hud hideAnimated:YES];
    }

    
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (isfailure) {
        MBProgressHUD *errorHUD = [[MBProgressHUD alloc]initWithView:view];
        errorHUD.label.text =  @"数据请求失败";
        errorHUD.mode = MBProgressHUDModeText;
        [view addSubview:errorHUD];
        [errorHUD showAnimated:YES];
        [errorHUD hideAnimated:YES afterDelay:2.5];
        NSLog(@"aaasdsadasdas");
        isfailure();
        [hud hideAnimated:YES];

    }

}];


}
@end
