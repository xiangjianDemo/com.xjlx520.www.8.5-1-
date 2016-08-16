//
//  Content_TableViewCell.m
//  com.xjlx520.www
//
//  Created by 勇 舒 on 16/8/12.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "Content_TableViewCell.h"

@implementation Content_TableViewCell

// 重写cell的高度
- (void)setFrame:(CGRect)frame{
    frame.origin.x += 2;// 设置起点
    
    frame.size.width -= 4;// 设置宽度
    [super setFrame:frame];
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
