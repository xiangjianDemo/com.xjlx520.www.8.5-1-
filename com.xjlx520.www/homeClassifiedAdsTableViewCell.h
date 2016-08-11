//
//  homeClassifiedAdsTableViewCell.h
//  享见1.0
//
//  Created by 勇 舒 on 16/6/21.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class homeClassifiedAdsTableViewCell;
// *****协议
@protocol homeClassifiedAdsTableViewCellDelegate <NSObject>

- (void)didTouchButton:(UIButton *)button addTableViewCell:(homeClassifiedAdsTableViewCell *)cell;

@end

@interface homeClassifiedAdsTableViewCell : UITableViewCell
// *****接口
@property(nonatomic,assign)id<homeClassifiedAdsTableViewCellDelegate>delegate;
@property(nonatomic,strong)UICollectionView *colltionView;

@end
