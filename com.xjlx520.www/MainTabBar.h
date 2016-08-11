//
//  MainTabBar.h
//  享见1.0
//
//  Created by 勇 舒 on 16/6/14.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainTabBar;
@protocol MainTabBarDelegate <NSObject>

@optional
- (void)tabBar:(MainTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag;
- (void)tabBarClickWriteButton:(MainTabBar *)tabBar;

@end

@interface MainTabBar : UIView
- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem;
@property(nonatomic,weak)id<MainTabBarDelegate>delegate;

@end
