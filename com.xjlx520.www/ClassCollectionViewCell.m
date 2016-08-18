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
        self.img = [[UIImageView alloc] init];
        self.img.userInteractionEnabled = YES;
        
    }
    return self;
}
@end
