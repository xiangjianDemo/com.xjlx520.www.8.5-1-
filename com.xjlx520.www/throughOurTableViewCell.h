//
//  throughOurTableViewCell.h
//  享见1.0
//
//  Created by 勇 舒 on 16/6/22.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class throughOurTableViewCell;
// ****协议
@protocol throughOurTableViewCellDelegate <NSObject>

@end

@interface throughOurTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton *button1;
@property(nonatomic,strong)UIButton *button2;
@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UILabel *label2;

@end
