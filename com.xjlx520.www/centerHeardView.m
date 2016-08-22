//
//  centerHeardView.m
//  com.xjlx520.www
//
//  Created by popperAndDeveloperY on 16/8/19.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "centerHeardView.h"
#import <SDAutoLayout.h>
@implementation centerHeardView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self step];
    }
    return self;
}
-(void)step{
    UIButton * heardbutton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [heardbutton  setBackgroundImage:[UIImage imageNamed:@"tab_3_normal"] forState:UIControlStateNormal];
    _heardButton = heardbutton;
    [self addSubview:heardbutton];
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = [UIColor orangeColor];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _LoginButton = loginButton;
    [self addSubview:loginButton];
    _heardButton.sd_layout.widthRatioToView(self,0.2).centerXEqualToView(self).centerYEqualToView(self).heightEqualToWidth();
    _LoginButton.sd_layout.topSpaceToView(_heardButton,kScreenWidth/20).widthRatioToView(_heardButton,1.2).bottomSpaceToView(self,kScreenWidth/30).centerXEqualToView(self);
}
@end
