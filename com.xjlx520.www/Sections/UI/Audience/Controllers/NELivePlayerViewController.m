//
//  NELivePlayerViewController.m
//  NELivePlayerDemo
//
//  Created by NetEase on 15-10-10.
//  Copyright (c) 2015年 netease. All rights reserved.
//

#import "NELivePlayerViewController.h"
#import "NELivePlayerControl.h"
#import "NTESGlobalMacro.h"
#import "NELivePlayerController.h"
#import "UIView+NE.h"
#import "UIAlertView+NE.h"
#import <SDAutoLayout.h>
#import "NHHeader.h"
#import "NHCarViews.h"
#import "NHPlaneViews.h"

@interface NELivePlayerViewController ()
{
    BOOL _isHardware;
}

@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, strong) UIButton *playQuitBtn;
@property (nonatomic, strong) UIActivityIndicatorView *bufferingIndicate;
@property (nonatomic, strong) UILabel *bufferingReminder;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *flowerBtn;
@property (nonatomic, strong) UIButton *carBtn;
@property (nonatomic, strong) UIButton *planteBtn;
@property (nonatomic, weak) NHPresentFlower *flower;

@end
@implementation NELivePlayerViewController

- (instancetype)initWithURL:(NSURL *)url andDecodeParm:(NSMutableArray *)decodeParm {
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.url = url;
        self.decodeType = [decodeParm objectAtIndex:0];
        self.mediaType = [decodeParm objectAtIndex:1];
        _isHardware = YES;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor=[UIColor blackColor];
    self.playerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    self.mediaControl = [[NELivePlayerControl alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth,UIScreenHeight)];
    
    //退出按钮
    self.playQuitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playQuitBtn.frame = CGRectMake(12, 12, 44, 44);
    [self.playQuitBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [self.playQuitBtn addTarget:self action:@selector(onClickBack:) forControlEvents:UIControlEventTouchUpInside];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [self.playBtn addTarget:self action:@selector(onClickPause:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBtn sizeToFit];
    self.playBtn.centerX = self.view.width * .5f;
    self.playBtn.bottom  = self.view.height - 30.f;
    
    //缓冲提示
    self.bufferingIndicate = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.bufferingIndicate setCenter:CGPointMake(UIScreenWidth/2, UIScreenHeight/2)];
    [self.bufferingIndicate setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.bufferingIndicate.hidden = YES;
    
    self.bufferingReminder = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [self.bufferingReminder setCenter:CGPointMake(UIScreenWidth/2, UIScreenHeight/2 - 50)];
    self.bufferingReminder.text = @"缓冲中";
    self.bufferingReminder.textAlignment = NSTextAlignmentCenter; //文字居中
    self.bufferingReminder.textColor = [UIColor whiteColor];
    self.bufferingReminder.hidden = YES;

    if ([self.decodeType isEqualToString:@"hardware"]) {
        _isHardware = YES;
    }
    else if ([self.decodeType isEqualToString:@"software"]) {
        _isHardware = NO;
    }

    [NELivePlayerController setLogLevel:NELP_LOG_DEBUG];
    //设置livePlayer类----API
    self.liveplayer = [[NELivePlayerController alloc] initWithContentURL:self.url];
    if (self.liveplayer == nil) { // 返回空则表示初始化失败
        NSLog(@"player initilize failed, please tay again!");
    }
    self.liveplayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.liveplayer.view.frame = self.playerView.bounds;
    
    [self.liveplayer setScalingMode:NELPMovieScalingModeAspectFill];
    
    [self.view addSubview:self.liveplayer.view];
    [self.view addSubview:self.bufferingIndicate];
    [self.view addSubview:self.bufferingReminder];
    [self.view addSubview:self.playQuitBtn];
    [self.view addSubview:self.playBtn];
    [self giveGiftButtons];
    self.mediaControl.delegatePlayer = self.liveplayer;
}
-(void)giveGiftButtons{
    _flowerBtn =  ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"送花" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(giveflower) forControlEvents: UIControlEventTouchUpInside ];
        [self.view addSubview:button];
        button.sd_layout.rightEqualToView(self.view).centerYEqualToView(self.view).widthRatioToView(self.view,0.1).heightRatioToView(self.view,0.05);
        button;
    });
    _carBtn =  ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"跑车" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(givecar) forControlEvents: UIControlEventTouchUpInside ];
        [self.view addSubview:button];
        button.sd_layout.rightEqualToView(self.view).topSpaceToView(_flowerBtn,kScreenWidth/30).widthRatioToView(self.view,0.1).heightRatioToView(self.view,0.05);
        button;
    });
    _planteBtn =  ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"飞机" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(givePlante) forControlEvents: UIControlEventTouchUpInside ];
        [self.view addSubview:button];
        button.sd_layout.rightEqualToView(self.view).topSpaceToView(_carBtn,kScreenWidth/30).widthRatioToView(self.view,0.1).heightRatioToView(self.view,0.05);
        button;
    });

}
-(void)givePlante{
    NHPlaneViews *plane = [NHPlaneViews loadPlaneViewWithPoint:CGPointMake(NHBounds.width + 232, 0)];
    //plane.curveControlAndEndPoints 用法同carView一样
    
    [plane addAnimationsMoveToPoint:CGPointMake(NHBounds.width, 100) endPoint:CGPointMake(-500, 410)];
    [self.view addSubview:plane];

}
-(void)givecar{
    NHCarViews *car = [NHCarViews loadCarViewWithPoint:CGPointZero];
    
    //数组中放CGRect数据，CGRect的x和y分别作为控制点的x和y，CGRect的width和height作为结束点的x和y
    //方法如下：数组内的每个元素代码一个控制点和结束点
    NSMutableArray *pointArrs = [[NSMutableArray alloc] init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 2;
    [pointArrs addObject:NSStringFromCGRect(CGRectMake(width, 300, width, 300))];
    //    pointArrs addObject:...添加更多的CGRect
    car.curveControlAndEndPoints = pointArrs;
    
    [car addAnimationsMoveToPoint:CGPointMake(0, 100) endPoint:CGPointMake(self.view.bounds.size.width +166, 500)];
    [self.view addSubview:car];

}
-(void)giveflower{
    if (_flower == nil) {
        [self addFlowerView];
    }else{
        _flower.effect = NHSendEffectSpring;
        //_flower.scaleValue = @[@4.2,@3.5,@1.2,@3.8,@3.3,@3.0,@2.0,@1.0];
        [_flower continuePresentFlowers];
    }
}
- (void)addFlowerView{
    NHPresentFlower *flower = [[NHPresentFlower alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 50)presentFlowerEffect:NHSendEffectShake];
    flower.autoHiddenTime = 5;
    [self.view addSubview:flower];
    _flower = flower;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"start live player , version = %@", [self.liveplayer getSDKVersion]);
    
    if ([self.mediaType isEqualToString:@"livestream"] ) {
        [self.liveplayer setBufferStrategy:NELPLowDelay]; //直播低延时模式
    }
    else {
        [self.liveplayer setBufferStrategy:NELPAntiJitter]; //点播抗抖动
    }
    [self.liveplayer setScalingMode:NELPMovieScalingModeAspectFit];
    [self.liveplayer setShouldAutoplay:YES]; //设置prepareToPlay完成后是否自动播放
    [self.liveplayer setHardwareDecoder:_isHardware]; //设置解码模式，是否开启硬件解码
    [self.liveplayer setPauseInBackground:NO]; //设置切入后台时的状态，暂停还
    [self.liveplayer prepareToPlay]; //初始化视频文件
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.liveplayer shutdown]; //退出播放并释放相关资源
    [self.liveplayer.view removeFromSuperview];
    self.liveplayer = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerDidPreparedToPlay:)
                                                 name:NELivePlayerDidPreparedToPlayNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NeLivePlayerloadStateChanged:)
                                                 name:NELivePlayerLoadStateChangedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlayBackFinished:)
                                                 name:NELivePlayerPlaybackFinishedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstVideoDisplayed:)
                                                 name:NELivePlayerFirstVideoDisplayedNotification
                                               object:_liveplayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerReleaseSuccess:)
                                                 name:NELivePlayerReleaseSueecssNotification
                                               object:_liveplayer];
}



#pragma mark - IBAction
//退出播放
- (void)onClickBack:(id)sender
{
    if (self.presentingViewController) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}


//暂停播放
- (void)onClickPause:(id)sender
{
    switch (self.liveplayer.playbackState) {
        case NELPMoviePlaybackStatePaused:
            [self.liveplayer play];
            [self.playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
            break;
        case NELPMoviePlaybackStatePlaying:
            [self.liveplayer pause];
            [self.playBtn setImage:[UIImage imageNamed:@"restart"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}


- (void)NELivePlayerDidPreparedToPlay:(NSNotification*)notification
{
    NSLog(@"NELivePlayerDidPreparedToPlay");
    [self.liveplayer play]; //开始播放
}

- (void)NeLivePlayerloadStateChanged:(NSNotification*)notification
{
    NELPMovieLoadState nelpLoadState = _liveplayer.loadState;
    
    if (nelpLoadState == NELPMovieLoadStatePlaythroughOK)
    {
        NSLog(@"finish buffering");
        self.bufferingIndicate.hidden = YES;
        self.bufferingReminder.hidden = YES;
        [self.bufferingIndicate stopAnimating];
    }
    else if (nelpLoadState == NELPMovieLoadStateStalled)
    {
        NSLog(@"begin buffering");
        self.bufferingIndicate.hidden = NO;
        self.bufferingReminder.hidden = NO;
        [self.bufferingIndicate startAnimating];
    }
}

- (void)NELivePlayerPlayBackFinished:(NSNotification*)notification
{
    switch ([[[notification userInfo] valueForKey:NELivePlayerPlaybackDidFinishReasonUserInfoKey] intValue])
    {
        case NELPMovieFinishReasonPlaybackEnded:
            if ([self.mediaType isEqualToString:@"livestream"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"主播已停止直播，直播结束" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert showAlertWithCompletionHandler:^(NSInteger index) {
                    if (self.presentingViewController)
                    {
                        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                    };
                }];
            }
            break;
            
        case NELPMovieFinishReasonPlaybackError:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"直播失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert showAlertWithCompletionHandler:^(NSInteger index) {
                if (self.presentingViewController)
                {
                    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                };
            }];
        }
            break;
            
        case NELPMovieFinishReasonUserExited:
            break;
            
        default:
            break;
    }
}

- (void)NELivePlayerFirstVideoDisplayed:(NSNotification*)notification
{
    NSLog(@"first video frame rendered!");
}

- (void)NELivePlayerReleaseSuccess:(NSNotification*)notification
{
    NSLog(@"resource release success!");
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NELivePlayerReleaseSueecssNotification object:_liveplayer];
}


@end
