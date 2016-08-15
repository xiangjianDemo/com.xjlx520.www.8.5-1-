//
//  NECancelBtn.m
//  LSMediaCaptureDemo
//
//  Created by NetEase on 5/23/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSMediaCapture.h"

@interface NEMediaCaptureViewController : UIViewController

@property(nonatomic,assign)NSInteger curFilterIndex;
@property(nonatomic,strong)UIButton *curFilterButton;

- (instancetype)initWithUrl:(NSString*)url sLSctx:(LSVideoParaCtx)sLSctx;


@end
