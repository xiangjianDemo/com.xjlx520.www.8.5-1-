//
//  homeClassCollectionViewCell.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/12.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "homeClassCollectionViewCell.h"

@implementation homeClassCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        
        
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetWidth(self.frame)-10)];
        self.imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.imageView.image = [UIImage imageNamed:@"wo.png"];
        [self addSubview:self.imageView];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imageView.frame), CGRectGetWidth(self.frame)-10, 20)];
        self.text.text = @"汽车服务";
        self.text.backgroundColor = [UIColor brownColor];
        self.text.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.text];
    }
    return self;
}
@end
