//
//  CityListViewController.h
//  享见1.0
//
//  Created by 勇 舒 on 16/7/20.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import <UIKit/UIKit.h>

// 协议
@protocol changeCityDelegate <NSObject>
- (void)changeCity:(NSString *)city_id;
@end

@interface CityListViewController : UIViewController
@property NSArray *citylist;

@property (nonatomic, assign) NSObject<changeCityDelegate> *deleagte;

@end
