//
//  NENormalView.m
//  LSMediaCaptureDemo
//
//  Created by NetEase on 5/23/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import "NEFilterRightView.h"
#import "NTESGlobalMacro.h"
@interface NEFilterRightView()

@end

@implementation NEFilterRightView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIEdgeInsets insets = UIEdgeInsetsMake(15, 15, 15, 15);
        [self setBackgroundImage:[[UIImage imageNamed:@"icon_filter_bg_normal"] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [self setBackgroundImage:[[UIImage imageNamed:@"icon_filter_bg_press"] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch] forState:UIControlStateSelected];
        
        [self setImage:[UIImage imageNamed:@"icon_normal_b_nromal"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"icon_normal_b_press"] forState:UIControlStateSelected];
        
        [self setTitle:@"普通" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
    }
    return self;
}

@end
