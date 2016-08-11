//
//  CityListViewController.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/20.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "CityListViewController.h"
#import "Net.h"

//#define kScreenWidth     [UIScreen mainScreen].bounds.size.width
//#define kScteenHeight   [UIScreen mainScreen].bounds.size.height


@interface CityListViewController ()

// 声明类的成员变量
@property Net *KYNet;

@end

@implementation CityListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _KYNet = [Net getInstance];// 得到单例
//    _KYNet.delegate = self;//将代理与viewcontroller链接
    kScreenWidth;
}

//  请求成功方法
- (void)getWeatherInfoSuccessFeedback:(id)feedbackInfo{
//    但服务器返回成功数据后，下列代码表示激活
    NSLog(@"%@",[feedbackInfo class]);
//    NSDictionary *dic = feedbackInfo;
//    NSArray *weather1 = [dic objectForKey:@"weather"];
//    NSDictionary *main1 = [dic objectForKey:@"main"];
//    NSDictionary *weather = [weather1 objectAtIndex:0];
//    NSString *temp = [NSString stringWithFormat:@"%@",[main1 objectForKey:@"temp"]];
//    NSString *weatherInfo = [NSString stringWithFormat:@"%@",[weather objectForKey:@"description"]];
    
}

// 请求失败方法
- (void)getWeatherInfoFailFeedback:(id)failInfo{
    NSLog(@"%@",failInfo);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
