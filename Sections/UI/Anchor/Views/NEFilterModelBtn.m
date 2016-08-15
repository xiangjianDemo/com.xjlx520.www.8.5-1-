//
//  NEFilterModelBtn.m
//  LSMediaCaptureDemo
//
//  Created by NetEase on 5/24/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import "NEFilterModelBtn.h"
#import "NTESGlobalMacro.h"
@implementation NEFilterModelBtn

-(instancetype)init{
    self=[super init];
    if (self) {
        CGFloat viewW = 77*UISreenWidthScale;
        CGFloat btnW = 28;
        CGFloat lblW = 40;
        self.frame = CGRectMake(0, 0,viewW, 77);
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(viewW/2.0-btnW/2.0, 15, btnW,btnW)];
        self.titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(viewW/2.0-lblW/2.0,CGRectGetMaxY(self.iconImageView.frame)+10, lblW, 15)];
        [self.titleLbl setTextColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3]];
        [self.titleLbl setTextAlignment:NSTextAlignmentCenter];
        self.titleLbl.font = [UIFont systemFontOfSize:13];
        self.seperateBar = [[UIView alloc] initWithFrame:CGRectMake(viewW-1, 0, 1, 77)];
        self.seperateBar.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.1];
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLbl];
        [self addSubview:self.seperateBar];
    }
    return self;
}

@end
