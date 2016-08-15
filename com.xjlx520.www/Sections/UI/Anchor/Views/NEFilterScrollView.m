//
//  NEFilterScrollView.m
//  LSMediaCaptureDemo
//
//  Created by NetEase on 5/24/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import "NEFilterScrollView.h"
#import "NTESGlobalMacro.h"
@implementation NEFilterScrollView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, UIScreenHeight-77,UIScreenWidth ,77);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        [self setShowsHorizontalScrollIndicator:NO];
    }
    return self;
}
@end
