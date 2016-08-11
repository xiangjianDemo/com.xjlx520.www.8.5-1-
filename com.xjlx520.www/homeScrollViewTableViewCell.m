//
//  homeScrollViewTableViewCell.m
//  享见1.0
//
//  Created by 勇 舒 on 16/6/21.
//  Copyright © 2016年 勇 舒. All rights reserved.
//**********滚动视图cell  首页大广告

#import "homeScrollViewTableViewCell.h"
#import "SDCycleScrollView.h"
#import "RollingAdvertisingTableViewController.h"
//#import "AFNetworking.h"

// 自定义宽、高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)



@interface homeScrollViewTableViewCell ()<SDCycleScrollViewDelegate>{
    //    滚动视图
    NSArray *imageArray;// 图片数组
    SDCycleScrollView *cycleScrollView1;//自定义滚动视图
    
}

@end
@implementation homeScrollViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *scroView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
        scroView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:scroView];
        
        
//        第三方滚动视图
        imageArray = @[[UIImage imageNamed:@"image0"],[UIImage imageNamed:@"image1"],[UIImage imageNamed:@"image2"],[UIImage imageNamed:@"image3"],[UIImage imageNamed:@"image3"]];
        
        cycleScrollView1 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/4) imagesGroup:imageArray];
        cycleScrollView1.delegate = self;
        cycleScrollView1.dotColor = [UIColor greenColor];//分页控制小图标颜色
        cycleScrollView1.pageControlDotSize = CGSizeMake(5, 5);//分页控件小图标大小
        cycleScrollView1.placeholderImage = [UIImage imageNamed:@""];//占位图，用于网络未加载到图片时
        [scroView addSubview:cycleScrollView1];
        
        
        }
    
    return self;
}

// 监听点击滚动视图方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    [self.delegate didTouchSDCycle:cycleScrollView1 andTableViewCell:self];
    NSLog(@"滚动视图^_^");
    
    
    
    
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
