//
//  PushTableViewCell.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/15.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "PushTableViewCell.h"
#import "DrawLineView.h"
@interface PushTableViewCell ()


@end

@implementation PushTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *scroView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)/10-10)];
        scroView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:scroView];
        
        self.pushImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)/10-10)];
        
        self.pushImage.image = [UIImage imageNamed:@"push"];
        [self addSubview:self.pushImage];
        
        self.pushLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/3, CGRectGetHeight([UIScreen mainScreen].bounds)/10/3-10, CGRectGetWidth([UIScreen mainScreen].bounds)/3+10, 35)];
        self.pushLabel.backgroundColor = [UIColor whiteColor];
        self.pushLabel.text = @"我的推送";
//        [self addSubview:self.pushLabel];
        
        
        
        
        }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
