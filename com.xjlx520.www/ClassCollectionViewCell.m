//
//  ClassCollectionViewCell.m
//  com.xjlx520.www
//
//  Created by 勇 舒 on 16/8/18.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "ClassCollectionViewCell.h"

@implementation ClassCollectionViewCell
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.img = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 10, 10)];
        self.img.userInteractionEnabled = YES;
        [self addSubview:self.img];
        
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 50, 30)];
        self.label1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label1];
    }
    return self;
}
@end
