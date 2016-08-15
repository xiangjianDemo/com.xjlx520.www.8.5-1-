//
//  NEEnterLiveButton.m
//  LSMediaCaptureDemo
//
//  Created by NetEase on 5/23/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import "NEEnterLiveButton.h"
#import "NTESGlobalMacro.h"
@implementation NEEnterLiveButton

-(instancetype)init{
    self=[super init];
    if (self) {
        //enterLiveBtn
        CGFloat enterLiveBtnW = 232;
        CGFloat enterLiveBtnH = 42;
        CGFloat enterLiveBtnX = UIScreenWidth/2.0-enterLiveBtnW/2.0;
        CGFloat enterLiveBtnY = UIScreenHeight-118*UISreenHeightScale;
        self.frame = CGRectMake(enterLiveBtnX, enterLiveBtnY, enterLiveBtnW, enterLiveBtnH);
        UIImage *orginImg = [UIImage imageNamed:@"enter_live_alive"];
        UIImage *stretchImg = [orginImg stretchableImageWithLeftCapWidth:orginImg.size.width*0.5 topCapHeight:orginImg.size.height*0.5];
        [self setBackgroundImage:stretchImg forState:UIControlStateNormal];
        [self setTitle:@"开始直播" forState:UIControlStateNormal];
        [self setTintColor:[UIColor whiteColor]];
       
    }
    return self;
}


@end
