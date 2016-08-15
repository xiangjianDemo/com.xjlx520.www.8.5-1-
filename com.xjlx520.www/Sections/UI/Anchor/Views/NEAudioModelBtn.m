//
//  NEAudioModelBtn.m
//  LSMediaCaptureDemo
//
//  Created by NetEase on 5/25/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import "NEAudioModelBtn.h"
#import "NTESGlobalMacro.h"
@implementation NEAudioModelBtn

-(instancetype)init{
    self = [super init];
    if (self) {
        CGFloat viewW = UIScreenWidth/3.0;
        CGFloat btnW = 28;
        CGFloat lblW = 40;
        self.frame=CGRectMake(0, 0,viewW, 77);
        self.iconImageView=[[UIImageView alloc] initWithFrame:CGRectMake(viewW/2.0-btnW/2.0, 15, btnW,btnW)];
        self.titleLable=[[UILabel alloc] initWithFrame:CGRectMake(viewW/2.0-lblW/2.0,CGRectGetMaxY(self.iconImageView.frame)+10, lblW, 15)];
        [self.titleLable setTextColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3]];
        [self.titleLable setTextAlignment:NSTextAlignmentCenter];
        self.titleLable.font=[UIFont systemFontOfSize:13];
        self.seperateBar=[[UIView alloc] initWithFrame:CGRectMake(viewW-1, 0, 1, 77)];
        self.seperateBar.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.1];
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLable];
        [self addSubview:self.seperateBar];
    }
    return self;
}
@end
