//
//  YXPMBProgressView.m
//  com.xjlx520.www
//
//  Created by popperAndDeveloperY on 16/8/18.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "YXPMBProgressView.h"
#import "MBProgressHUD.h"
@implementation YXPMBProgressView
+(void)ProgressHUDText:(NSString *)text andShowTime:(NSTimeInterval)time{
      UIView *view = (UIView*)[[[UIApplication sharedApplication]delegate]window];
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:view];
  HUD.label.text =  text;
HUD.mode = MBProgressHUDModeText;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:time];
 }
@end
