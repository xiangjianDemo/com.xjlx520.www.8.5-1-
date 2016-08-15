//
//  NEStartLiveStreamViewController.m
//  LSMediaCaptureDemo
//
//  Created by NetEase on 5/12/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import "NEStartLiveStreamViewController.h"
#import "NEMediaCaptureViewController.h"
#import "NEPushUrlViewController.h"
#import "NEFilterLeftView.h"
#import "NEFilterRightView.h"
#import "NEEnterLiveButton.h"
#import "NEModelLabel.h"

@interface NEStartLiveStreamViewController (){
    LSVideoParaCtx sLSCtx;//现在只是提供设置视频参数
}

@property (nonatomic,strong) UIImageView   *bgImageView;
@property (nonatomic,strong) UIButton *cancellBtn;
@property (nonatomic,strong) NEModelLabel *modelSelectLbl;
@property (nonatomic,strong) NEEnterLiveButton *enterLiveBtn;
@property (nonatomic,strong) NEFilterLeftView  *leftBtn;
@property (nonatomic,strong) NEFilterRightView *rightBtn;


@end

@implementation NEStartLiveStreamViewController

#pragma -mark - NEPassUrl
- (void)passUrl:(NSString *)url{
    self.pushUrl = url;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    self.bgImageView.frame = self.view.bounds;
    self.bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.bgImageView];
    
    [self setUpSCtx];
    [self setUpSubviews];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)setUpSCtx{
    //默认高清 以后可根据网络状况比如wifi或4G或3G来建议用户选择不同质量
    sLSCtx.interfaceOrientation = LS_CAMERA_ORIENTATION_PORTRAIT;
    sLSCtx.cameraPosition = LS_CAMERA_POSITION_FRONT;
    sLSCtx.bitrate = 600000;
    sLSCtx.fps = 15;
    sLSCtx.videoStreamingQuality = LS_VIDEO_QUALITY_HIGH;
    sLSCtx.isCameraZoomPinchGestureOn = YES;
    sLSCtx.isCameraFlashEnabled = YES;
    sLSCtx.isVideoWaterMarkEnabled = YES;
    sLSCtx.videoRenderMode = LS_VIDEO_RENDER_MODE_SCALE_16x9;
    sLSCtx.isVideoFilterOn = YES;
    sLSCtx.filterType = LS_GPUIMAGE_NORMAL;
}

-(void)setUpSubviews{
    
    //取消按钮
    [self.view addSubview:self.cancellBtn];
    [self.cancellBtn addTarget:self action:@selector(cancellLiveStream) forControlEvents:UIControlEventTouchUpInside];
    
    //filterLeftView
    [self.view addSubview:self.leftBtn];
    self.leftBtn.selected = YES;
    
    //NENormalView
    [self.view addSubview:self.rightBtn];

    //modelSelectLbl
    self.modelSelectLbl = [[NEModelLabel alloc] init];
    [self.view addSubview:self.modelSelectLbl];
    
    //enterLiveBtn
    self.enterLiveBtn = [[NEEnterLiveButton alloc] init];
    [self.view addSubview:self.enterLiveBtn];
    [self.enterLiveBtn addTarget:self action:@selector(startLiveStream) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)startLiveStream{
    NEMediaCaptureViewController *vc = [[NEMediaCaptureViewController alloc] initWithUrl:self.pushUrl sLSctx:sLSCtx];
    NSLog(@"%@",self.pushUrl);
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)modeSelect:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (button == self.leftBtn) {
        sLSCtx.isVideoFilterOn = YES;
        self.leftBtn.selected  = YES;
        self.rightBtn.selected = NO;
    } else {
        sLSCtx.isVideoFilterOn = NO;
        self.leftBtn.selected  = NO;
        self.rightBtn.selected = YES;
    }
}

- (void)cancellLiveStream{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIButton *)cancellBtn
{
    if (!_cancellBtn) {
        
        CGFloat cancellBtnW = 20;
        CGFloat cancellBtnH = 20;
        CGFloat cancellBtnX = 10;
        CGFloat cancellBtnY = 25;

        _cancellBtn = [[UIButton alloc] initWithFrame:CGRectMake(cancellBtnX, cancellBtnY, cancellBtnW, cancellBtnH)];
        [_cancellBtn setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    }
    return _cancellBtn;
}

- (NEFilterLeftView *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [[NEFilterLeftView alloc] initWithFrame:CGRectMake(UIScreenWidth/2.0 - 25 - 100, 277, 100, 41)];
        [_leftBtn addTarget:self action:@selector(modeSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (NEFilterRightView *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [[NEFilterRightView alloc] initWithFrame:CGRectMake(UIScreenWidth/2.0 + 25, 277, 100, 40)];
        [_rightBtn addTarget:self action:@selector(modeSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

@end
