//
//  MainTableController.m
//  享见1.0
//
//  Created by 勇 舒 on 16/6/14.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "MainTableController.h"
#import "HomeViewController.h"
#import "FindViewController.h"
#import "NewsViewController.h"
#import "CenterViewController.h"
#import "HomeTableViewController.h"
#import "FindViewTableViewController.h"
#import "NewsViewTableViewController.h"
#import "CenterTableViewController.h"

#import "MainNavigationController.h"


@interface MainTableController ()


@end
@implementation MainTableController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self SetupMainTabBar];
    [self SetupAllControllers];
    
//    导航栏颜色
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
//    backView.backgroundColor = [UIColor colorWithRed:10.0/255.0 green:104.0/255.0 blue:53.0/255.0 alpha:1.0];
//    [self.tabBarController.tabBar insertSubview:backView atIndex:0];
//    self.tabBarController.tabBar.opaque = YES;
//    [self.view addSubview:backView];
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
- (void)SetupMainTabBar{
    
    
}

- (void)SetupAllControllers{
//    NSArray *titles = @[@"首页", @"发现", @"消息", @"我的"];
//    NSArray *images = @[@"icon_tabbar_home~iphone", @"icon_tabbar_subscription~iphone", @"icon_tabbar_notification~iphone", @"icon_tabbar_me~iphone"];
//    NSArray *selectedImages = @[@"icon_tabbar_home_active~iphone", @"icon_tabbar_subscription_active~iphone", @"icon_tabbar_notification_active~iphone", @"icon_tabbar_me_active~iphone"];
//    首页

    
    HomeTableViewController * homeVc = [[HomeTableViewController alloc] init];
    [self SetupChildVc:homeVc title:@"享见" image:@"tab_0_normal" selectedImage:@""];

    //    消息
    NewsViewTableViewController * notificationVc = [[NewsViewTableViewController alloc] init];
    [self SetupChildVc:notificationVc title:@"朋友" image:@"tab_1_normal" selectedImage:@""];
    //    发现
    FindViewTableViewController * subscriptionVc = [[FindViewTableViewController alloc] init];
    [self SetupChildVc:subscriptionVc title:@"发现" image:@"tab_4_normal" selectedImage:@""];
    //    个人中心
     CenterViewController *meVc = [[CenterViewController alloc] init];
    [self SetupChildVc:meVc title:@"我" image:@"tab_3_normal" selectedImage:@""];
    
}

+ (void)initialize{
    UITabBarItem *barItem = [UITabBarItem appearance];
//    设置选中的颜色
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [barItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    
    
}

- (void)SetupChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:childVc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectImage = [UIImage imageNamed:selectedImageName];
    nav.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.tintColor = [UIColor whiteColor];
    [self addChildViewController:nav];
    
    
}





@end
