//
//  TheAFNetWorking.h
//  com.xjlx520.www
//
//  Created by 勇 舒 on 16/8/8.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import <AFNetworking/AFHTTPSessionManager.h>
@interface TheAFNetWorking : NSObject
//@property(nonatomic,copy)void((^Block)(NSDictionary *dic));
+(instancetype)sharedInstance;
+(void)postHttpsURL:(NSString *)url parameters:(NSDictionary *)parameter AndSuccess:(void(^)(NSArray *dic))dic orfailure:(void(^)())isfailure showHUD:(BOOL)show;
+(void)getHttpsURL:(NSString *)url parameters:(NSDictionary *)parameter AndSuccess:(void(^)(NSArray *dic))dic orfailure:(void(^)())isfailure showHUD:(BOOL)show;
+(NSString *)httpURLStr:(NSString *)url;
@end
