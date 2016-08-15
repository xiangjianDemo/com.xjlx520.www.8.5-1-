//
//  throughOurTableViewCell.m
//  享见1.0
//
//  Created by 勇 舒 on 16/6/22.
//  Copyright © 2016年 勇 舒. All rights reserved.
//  ＊＊＊＊＊＊＊乐播

#import "throughOurTableViewCell.h"
#import <SDAutoLayout.h>
@implementation throughOurTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self step];
        
    }
    return self;
}
-(void)step{
    UIView *contentView = self.contentView;
    UIView *view1 = ({
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithRed:0.061 green:0.452 blue:0.202 alpha:1.000];
        [contentView addSubview:view];
        view.sd_layout.topSpaceToView(contentView,0).heightIs(1).leftEqualToView(contentView).rightSpaceToView(contentView,0);
        view;
    });
    UIView *view2 = ({
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithRed:0.068 green:0.500 blue:0.223 alpha:1.000];
          [contentView addSubview:view];
        view.sd_layout.bottomSpaceToView(contentView,0).heightIs(1).leftEqualToView(contentView).rightSpaceToView(contentView,0);
        view;
    });
  
    _button1 = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [contentView addSubview:button];
        button.sd_layout.leftSpaceToView(contentView,kScreenWidth/15).topSpaceToView(contentView,kScreenWidth/60).widthIs(kScreenWidth/2-kScreenWidth/14).heightIs(kScreenWidth/3.5-kScreenWidth/36);
       
        button;
    });
    _button2 = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
          [contentView addSubview:button];
        button.sd_layout.rightSpaceToView(contentView,kScreenWidth/15).topSpaceToView(contentView,kScreenWidth/60).widthIs(kScreenWidth/2-kScreenWidth/14).heightIs(kScreenWidth/3.5-kScreenWidth/36);
    
        button;
    });
    UIView *view3 = ({
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithRed:0.068 green:0.500 blue:0.223 alpha:1.000];
        [contentView addSubview:view];
        view.sd_layout.topSpaceToView(_button2,5).heightIs(1).leftEqualToView(contentView).rightSpaceToView(contentView,0);
        
        view;
    });

    _label1 = ({
        UILabel *label = [[UILabel alloc]init];
     
        label.textAlignment = NSTextAlignmentCenter;
//         label.backgroundColor = [UIColor redColor];
        [contentView addSubview:label];
        label.sd_layout.widthIs(kScreenWidth/2).autoHeightRatio(0).topSpaceToView(_button1,kScreenWidth/37).centerXEqualToView(_button1);
        
        label;
    });
   _label2 = ({
        UILabel *label = [[UILabel alloc]init];
//        label.backgroundColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:label];
        label.sd_layout.widthIs(kScreenWidth/2).autoHeightRatio(0).topSpaceToView(_button1,kScreenWidth/37).centerXEqualToView(_button2);
        label;
    });

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
