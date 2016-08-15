//
//  NEStartLiveStreamViewController.h
//  LSMediaCaptureDemo
//
//  Created by NetEase on 5/12/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTESGlobalMacro.h"

@interface NEStartLiveStreamViewController <NEPassUrl>: UIViewController

@property (nonatomic,copy) NSString *pushUrl;

@end
