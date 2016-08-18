//
//  FourCollectionViewCell.m
//  com.xjlx520.www
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "FourCollectionViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>
@interface FourCollectionViewCell (){
    
    UIImageView *_imageView;
    UILabel *_title;
    UILabel *_biaoti;
    UILabel *_people;
    UILabel *_roomNum;
    
}
@end

@implementation FourCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self){
        
        [self createView];
    }
    return self;
}

- (void)createView{
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetWidth(self.contentView.frame)*24/26)];
    _biaoti = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame)-15,CGRectGetWidth(self.contentView.frame), 15)];
    _biaoti.textColor = [UIColor redColor];
    _title = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_biaoti.frame), (CGRectGetMaxX(_imageView.frame)*2/3)-10, 30)];
    _title.numberOfLines = 0;
    _title.font = [UIFont systemFontOfSize:15];
    _people = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_title.frame)+10, CGRectGetMaxY(_biaoti.frame), (CGRectGetMaxX(_imageView.frame)*1/3), 30)];
    _people.font = [UIFont systemFontOfSize:12];
    _roomNum = [UILabel new];
    _roomNum.frame = CGRectMake(0, CGRectGetMaxY(_title.frame)-10,CGRectGetWidth(self.contentView.frame)*24/26,30);
    _roomNum.font = [UIFont systemFontOfSize:15];
    _roomNum.textColor = [UIColor lightGrayColor];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@"http://upload.69xiu.com/upload/roomimg/2016/07/19/25255120578e33adb4774_370x280.jpg"]placeholderImage:[UIImage imageNamed:@"XJian"]];
    _biaoti.text = [NSString stringWithFormat:@"城市"];
    _title.text = [NSString stringWithFormat:@"房名"];
    _people.text = [NSString stringWithFormat:@"人数"];
    _roomNum.text = [NSString stringWithFormat:@"房间号"];
    
    
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_biaoti];
    [self.contentView addSubview:_title];
    [self.contentView addSubview:_people];
    [self.contentView addSubview:_roomNum];
    
    
    
}

@end
