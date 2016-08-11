//
//  FindViewController.m
//  享见1.0
//
//  Created by 勇 舒 on 16/6/14.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController ()

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"发现";
    
    //    设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:10.0/255.0 green:104.0/255.0 blue:53.0/255.0 alpha:1.0]];
    self.navigationController.navigationBar.translucent = YES;
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
