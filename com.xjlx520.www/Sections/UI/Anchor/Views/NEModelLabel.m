//
//  NEModelLabel.m
//  LSMediaCaptureDemo
//
//  Created by NetEase on 5/23/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import "NEModelLabel.h"
#import "NTESGlobalMacro.h"
@implementation NEModelLabel
-(instancetype)init{
    self=[super init];
    if (self) {
        //modelSelectLbl
        CGFloat modelSelectLblW = 300;
        CGFloat modelSelectLblH = 28;
        CGFloat modelSelectLblX = UIScreenWidth/2.0-modelSelectLblW/2.0;
        CGFloat modelSelectLblY = 185;
        self.frame = CGRectMake(modelSelectLblX, modelSelectLblY, modelSelectLblW, modelSelectLblH);
        self.textAlignment = NSTextAlignmentCenter;
        self.text = @"美图模式选择";
        [self setFont:[UIFont systemFontOfSize:26]];
        [self setTextColor:[UIColor whiteColor]];
    }
    return self;
}


@end
