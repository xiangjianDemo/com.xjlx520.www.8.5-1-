//
//  homeScrollViewTableViewCell.h
//  享见1.0
//
//  Created by 勇 舒 on 16/6/21.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@class homeScrollViewTableViewCell;
// ****协议
@protocol homeScrollViewTableViewCellDelegate <NSObject>

- (void)didTouchSDCycle:(SDCycleScrollView *)SDCycle andTableViewCell:(homeScrollViewTableViewCell *)cell;

@end

@interface homeScrollViewTableViewCell : UITableViewCell
//*****接口
@property (nonatomic,assign)id<homeScrollViewTableViewCellDelegate>delegate;

@end
