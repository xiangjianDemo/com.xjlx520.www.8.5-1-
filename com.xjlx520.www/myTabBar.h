//
//  myTabBar.h
//  享见1.0
//
//  Created by 勇 舒 on 16/6/15.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myTabBar;
@protocol myTabBarDelegate <NSObject>

@optional
- (void)taBbar:(myTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag;
- (void)taBbarClickWriteButton:(myTabBar *)taBbar;


@end

@interface myTabBar : UIView
- (void)addTaBabarButtonWithTabBarItem:(UITabBarItem *)tabBarItem;
@property(nonatomic,weak)id<myTabBarDelegate>delegate;

@end
