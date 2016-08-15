//
//  NELivePlayerViewController.h
//  NELivePlayerDemo
//
//  Created by NetEase on 15-10-10.
//  Copyright (c) 2015年 netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NELivePlayer.h"

@class NELivePlayerControl;
@interface NELivePlayerViewController : UIViewController

@property(atomic, strong) NSURL *url;
@property(atomic, strong) NSString *decodeType;
@property(atomic, strong) NSString *mediaType;
@property(atomic, retain) id<NELivePlayer> liveplayer;

- (id)initWithURL:(NSURL *)url andDecodeParm:(NSMutableArray *)decodeParm;

@property(nonatomic, strong)  NELivePlayerControl *mediaControl;

@end

