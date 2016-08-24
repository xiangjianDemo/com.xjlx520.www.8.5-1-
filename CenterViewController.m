//
//  CenterViewController.m
//  享见1.0
//
//  Created by 勇 舒 on 16/6/14.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "CenterViewController.h"
#import "LoginViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"我";
    //    设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:10.0/255.0 green:104.0/255.0 blue:53.0/255.0 alpha:1.0]];
    self.navigationController.navigationBar.translucent = YES;
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, 64+20, 80, 25);
    loginButton.backgroundColor = [UIColor orangeColor];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.tag = 10;
    [self.view addSubview:loginButton];
    
}
- (void)action:(UIButton *)sender{
    
    LoginViewController *loggin = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loggin animated:YES];
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
