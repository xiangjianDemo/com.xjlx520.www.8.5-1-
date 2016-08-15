//
//  NECancelBtn.m
//  LSMediaCaptureDemo
//
//  Created by NetEase on 5/23/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import "NEMediaCaptureViewController.h"
#import "MBProgressHUD.h"
#import "UIView+Toast.h"
#import "NTESGlobalMacro.h"
#import "NEFilterScrollView.h"
#import "NEFilterModelBtn.h"
#import "NEAudioModelBtn.h"
#import "NTESGlobalMacro.h"
#import "UIView+NE.h"

#define kFilterTableViewAnimationTime 0.2f

@interface NEMediaCaptureViewController () < UINavigationControllerDelegate>
//导航栏：返回
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic,strong) MBProgressHUD *hub;
//拍照 切换相机 查看统计信息
@property (nonatomic, strong) UIButton *switchButton;
//错误信息动态显示试图
@property(nonatomic,strong)UIAlertView *errorInfoView;
//相机预览视图
@property (nonatomic, strong) UIView *localPreview;
//存储滤镜的名称
@property (copy, nonatomic) NSArray* comboxDataSource;
//存储icon名称
@property (copy, nonatomic) NSArray *iconDataSource;
//存储伴音的名称
@property (copy, nonatomic) NSArray* audioDataSource;
//存储伴音icon名称
@property (copy, nonatomic) NSArray *audioIconSource;
//伴奏功能
@property(nonatomic,strong) UIButton* musicButton;
//滤镜列表的子控件
@property(nonatomic,strong) UILabel *filterListModLbl;
//滤镜按钮数组
@property(nonatomic,strong) NSMutableArray *filterBtnArray;
//滤镜按钮数组
@property(nonatomic,strong) NSMutableArray *audioBtnArray;

@property(nonatomic,strong) UIButton *touchBtn;
//直播SDK API
@property (nonatomic,strong) LSMediaCapture *mediaCapture;
//logo 标签
@property (nonatomic,strong) UIImageView *logoView;
//暂停按钮
@property (nonatomic,strong) UIButton *pauseBtn;
//相机按钮
@property (nonatomic,strong) UIButton *cameraBtn;
//滤镜按钮
@property (nonatomic,strong) UIButton *filterBtn;
//NEFilterScrollView
@property (nonatomic,strong) NEFilterScrollView *filterScrollView;
@property (nonatomic,strong) NEFilterModelBtn *filterModelBtn;
@property (nonatomic,strong) NEAudioModelBtn *audioModelBtn;
@property (nonatomic,strong) UIView *audioWrapView;

@property (nonatomic,assign) BOOL isLiving;

@end
@implementation NEMediaCaptureViewController{
    NSString* _streamUrl;
    LSVideoParaCtx _sVideoParaCtx;//推流视频参数设置
    BOOL _isMusicPlaying;
    dispatch_semaphore_t _resignActiveStartLiveStream;
    BOOL _needStartLive;
}

- (instancetype)initWithUrl:(NSString*)url sLSctx:(LSVideoParaCtx)sLSctx
{
    self = [super init];
    if(self) {
        _streamUrl = url;
        memcpy(&_sVideoParaCtx, &sLSctx, sizeof(LSVideoParaCtx));
        _isMusicPlaying = NO;
        _isLiving = NO;
        _resignActiveStartLiveStream = dispatch_semaphore_create(0);
        _needStartLive = NO;
    }
    return self;
}

#pragma mark - UI Setup
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _needStartLive = NO;
    }
    return self;
}
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor clearColor];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    //取消按钮
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(12, 26, 23, 23);
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    //logo标签
    UIImage *image = [UIImage imageNamed:@"NELogo"];
    self.logoView  = [[UIImageView alloc] initWithImage:image];
    self.logoView.frame = (CGRect){{UIScreenWidth-135,26},image.size};
    [self.view addSubview:self.logoView];
    
    CGFloat right   = 15.f;
    CGFloat bottom  = 15.f;
    CGFloat padding = 10.f;
    CGSize  buttonSize = CGSizeMake(47, 47);

    //pause按钮
    self.pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pauseBtn.size  = buttonSize;
    self.pauseBtn.left  = 12.f;
    self.pauseBtn.bottom = self.view.height - bottom;
    [self.pauseBtn setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [self.view addSubview:self.pauseBtn];
    [self.pauseBtn addTarget:self action:@selector(startButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    //music按钮
    self.musicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.musicButton.size  = buttonSize;
    self.musicButton.right = self.view.width - right;
    self.musicButton.bottom = self.view.height - bottom;
    [self.musicButton setBackgroundImage:[UIImage imageNamed:@"music"] forState:UIControlStateNormal];
    [self.view addSubview:self.musicButton];
    [self.musicButton addTarget:self action:@selector(musicButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat nextRight = self.musicButton.left;
    //filter按钮
    if (_sVideoParaCtx.isVideoFilterOn) {
        self.filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.filterBtn.size   = buttonSize;
        self.filterBtn.right  = nextRight - padding;
        self.filterBtn.bottom = self.view.height - bottom;
        [self.filterBtn setBackgroundImage:[UIImage imageNamed:@"filter"] forState:UIControlStateNormal];
        [self.view addSubview:self.filterBtn];
        [self.filterBtn addTarget:self action:@selector(mainFilterBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        
        nextRight = self.filterBtn.left;
    }
    
    //camera按钮
    self.cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cameraBtn.size   = buttonSize;
    self.cameraBtn.right  = nextRight - padding;
    self.cameraBtn.bottom = self.view.height - bottom;
    [self.cameraBtn setBackgroundImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [self.view addSubview:self.cameraBtn];
    [self.cameraBtn addTarget:self action:@selector(switchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //视图预览
    self.localPreview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width,  screenRect.size.height)];
    self.localPreview.backgroundColor = [UIColor clearColor];
      [self.view insertSubview:self.localPreview atIndex:0];
    
    //errorInfoView
    self.errorInfoView = [[UIAlertView alloc]initWithTitle:@"错误信息" message:@"直播出现错误则会抛出" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    //NEFilterScrollView
    self.filterScrollView = [[NEFilterScrollView alloc] init];
    [self.view addSubview:self.filterScrollView];
    self.filterScrollView.hidden = YES;
    
    //audioWrapView
    self.audioWrapView = [[UIView alloc] initWithFrame:CGRectMake(0, UIScreenHeight-77, UIScreenWidth, 77)];
    self.audioWrapView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    [self.view addSubview:self.audioWrapView];
    self.audioWrapView.hidden = YES;
    
    //touchBtn
    self.touchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backButton.frame), UIScreenWidth,UIScreenHeight-CGRectGetMaxY(self.backButton.frame) - self.filterScrollView.frame.size.height)];
    [self.view addSubview:self.touchBtn];
    
    [self.touchBtn addTarget:self action:@selector(touchBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    self.comboxDataSource = @[
                                @{@"name":@"普通",@"type":@(LS_GPUIMAGE_NORMAL)},
                                @{@"name":@"自然",@"type":@(LS_GPUIMAGE_ZIRAN)},
                                @{@"name":@"粉嫩",@"type":@(LS_GPUIMAGE_MEIYAN1)},
                                @{@"name":@"炫白",@"type":@(LS_GPUIMAGE_BEAUTY)},
                                @{@"name":@"怀旧",@"type":@(LS_GPUIMAGE_MEIYAN2)},
                                @{@"name":@"黑白",@"type":@(LS_GPUIMAGE_SEPIA)},
                            ];
    self.iconDataSource  = @[@"icon_pt",@"icon_na",@"icon_fn",@"icon_xb",@"icon_hj",@"icon_bw"];
    self.audioDataSource = @[@"无伴音",@"伴音1",@"伴音2"];
    self.audioIconSource = @[@"audio0",@"audio1",@"audio2"];
    
    [self setUpFilterBtn];
    [self setUpAudioModelBtn];
}


-(void)setUpAudioModelBtn{
    self.audioBtnArray= [[NSMutableArray alloc] init];
    CGFloat KSpan=UIScreenWidth/3.0;
   
    for(int num=0;num<3;num++){
        int x = num%3;
        //按钮
        NEAudioModelBtn *button = [[NEAudioModelBtn alloc] init];
        CGFloat btnX;
        if(num == 0){
            button.backgroundColor = [UIColor grayColor];
        }
        btnX=x*KSpan;
        CGRect tempRect = button.frame;
        tempRect.origin.x = btnX;
        button.frame = tempRect;
        button.titleLable.text = self.audioDataSource[num];
        NSString *imgNameStr = [[NSString alloc] initWithFormat:@"%@",self.audioIconSource[num]];
        button.iconImageView.image=[UIImage imageNamed:imgNameStr];
        button.tag = num + 200;
        [button addTarget:self action:@selector(audioBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.audioWrapView addSubview:button];
        [self.audioBtnArray addObject:button];
    }

}
- (void)mainFilterBtnPressed{
    self.filterScrollView.hidden = NO;
}
#pragma - mark - touchBtnPressed
- (void)touchBtnPressed{
    self.filterScrollView.hidden = YES;
    self.audioWrapView.hidden = YES;
}
#pragma mark - audioBtnPress:
- (void)audioBtnPress:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    for(int no=0;no<3;no++){
        UIButton *button = self.audioBtnArray[no];
        if (btn.tag==(no+200)) {
            button.backgroundColor = [UIColor grayColor];
        }else{
            button.backgroundColor = [UIColor blackColor];
        }
    }
    switch (btn.tag) {
        case 200://无伴音
             [_mediaCapture stopPlayMusic];//关闭音效
            break;
        case 201://伴音1
            [self playAudioMusicWithResource:@"lovest.mp3"];
            break;
        case 202://伴音2
            [self playAudioMusicWithResource:@"lovest.wav"];
            break;
        default:
            break;
    }

}

-(void)playAudioMusicWithResource:(NSString *)Resource{
    NSString * musicFileURL = [[NSBundle mainBundle] pathForResource:Resource ofType:nil];
    if (musicFileURL == nil) {
        NSLog(@"have not found music file");
        return;
    }
    if (![_mediaCapture startPlayMusic:musicFileURL withEnableSignleFileLooped:YES]) {
        NSLog(@"music file play failed");
        return;
    };
}

#pragma - mark - setUpFilterBtn
-(void)setUpFilterBtn{
    self.filterBtnArray = [[NSMutableArray alloc] init];
    CGFloat KSpan = 77 * UISreenWidthScale;
    self.filterScrollView.contentSize = CGSizeMake(KSpan * self.comboxDataSource.count, self.filterScrollView.height);
    
    for(int num = 0;num < self.comboxDataSource.count;num++){
        //按钮
        NEFilterModelBtn *button = [[NEFilterModelBtn alloc] init];
        CGFloat btnX;
        if(num==0){
            button.backgroundColor = [UIColor grayColor];
        }
        btnX=num*KSpan;
        CGRect tempRect = button.frame;
        tempRect.origin.x = btnX;
        button.frame = tempRect;
        button.titleLbl.text = self.comboxDataSource[num][@"name"];
        NSString *imgNameStr = [[NSString alloc] initWithFormat:@"%@",self.iconDataSource[num]];
        button.iconImageView.image = [UIImage imageNamed:imgNameStr];

        UIView *sepBar = [[UIView alloc] initWithFrame:CGRectMake(KSpan-1, 0, 1, 77)];
        sepBar.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.1];
        [button addSubview:sepBar];
        button.tag = num;
        [button addTarget:self action:@selector(filterBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.filterScrollView addSubview:button];
        [self.filterBtnArray addObject:button];

    }
}
#pragma mark - filterBtnPress
-(void)filterBtnPress:(id)sender{
    UIButton *btn = (UIButton *)sender;
    for(int no = 0;no < self.comboxDataSource.count;no++){
        UIButton *button = self.filterBtnArray[no];
        if (btn.tag == no) {
            NSLog(@"%ld",(long)no);
            
            button.backgroundColor = [UIColor grayColor];
            LSGpuImageFilterType type = (LSGpuImageFilterType)[self.comboxDataSource[no][@"type"] integerValue];
            [_mediaCapture setFilterType:type];

        }else{
            button.backgroundColor = [UIColor blackColor];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化直播参数，并创建音视频直播
    NSError* error = nil;
    LSLiveStreamingParaCtx paraCtx;
    paraCtx.eHaraWareEncType = LS_HRD_NO;
    paraCtx.eOutFormatType = LS_OUT_FMT_RTMP;
    paraCtx.eOutStreamType = LS_HAVE_AV; //这里可以设置推音视频流／音频流／视频流，如果只推送视频流，则不支持伴奏播放音乐
    memcpy(&paraCtx.sLSVideoParaCtx, &_sVideoParaCtx, sizeof(LSVideoParaCtx));
    paraCtx.sLSAudioParaCtx.bitrate = 64000;
    paraCtx.sLSAudioParaCtx.codec = LS_AUDIO_CODEC_AAC;
    paraCtx.sLSAudioParaCtx.frameSize = 2048;
    paraCtx.sLSAudioParaCtx.numOfChannels = 1;
    paraCtx.sLSAudioParaCtx.samplerate = 44100;
    
    _mediaCapture = [[LSMediaCapture alloc]initLiveStream:_streamUrl withLivestreamParaCtx:paraCtx];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onStartLiveStream:) name:LS_LiveStreaming_Started object:_mediaCapture];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onFinishedLiveStream:) name:LS_LiveStreaming_Finished object:_mediaCapture];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onBadNetworking:) name:LS_LiveStreaming_Bad object:_mediaCapture];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onSdkDealloc:) name:LS_LiveStreaming_SDK_dealloc object:_mediaCapture];
    if (error != nil) {
        return;
    }
    BOOL success = YES;
    success = [self requestMediaCapturerAccessWithCompletionHandler:^(BOOL value, NSError* error){
    }];
    if (!success) {
        return;
    }

    //打开摄像头预览
    [_mediaCapture startVideoPreview:self.localPreview];
    
    NSString* sdkVersion = [_mediaCapture getSDKVersionID];
    NSLog(@"sdk version:%@",sdkVersion);

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backgroundStopLiveStream:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(callEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [self showhub];//缓冲

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startPushLiveStream];
}

- (void)callEnterForeground:(NSNotification*)NSNotification
{
    //回到前台的时候，如果需要开启直播则打开直播
    
    [self.pauseBtn setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    
    if(_isLiving == NO && _needStartLive == YES)
    {
        
        [_mediaCapture startLiveStreamWithError:nil];
    }
}

//切到后台，默认是已经打开了直播，也就是onlivestreamstart消息已经收到的情况，如果正在打开直播，而用户就要切到后台，也没关系
- (void)backgroundStopLiveStream:(NSNotification*)notification
{
    UIApplication *app = [UIApplication sharedApplication];
    
    __block UIBackgroundTaskIdentifier backTaskId;
    
    backTaskId = [app beginBackgroundTaskWithExpirationHandler:^
                  
                  {
                      NSLog(@"===在额外申请的10分钟内依然没有完成任务===");
                     [app endBackgroundTask:backTaskId];
                  }];
    
    if(backTaskId == UIBackgroundTaskInvalid)
        
    {
        NSLog(@"===iOS版本不支持后台运行,后台任务启动失败===");
        return;
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       
                       NSLog(@"===额外申请的后台任务时间为: %f==="
                             ,  app.backgroundTimeRemaining);
                       
                       if(_isLiving == YES)
                       {
                           // 其他内存清理的代码也可以在此处完成
                           [_mediaCapture stopLiveStream:^(NSError *error) {
                               
                               if (error == nil) {
                                   NSLog(@"退到后台的直播结束了");
                                   _isLiving = NO;

                                   _needStartLive = YES;
                                   [app endBackgroundTask:backTaskId];
                               }
                               else{
                                   NSLog(@"退到后台的结束直播发生错误");
                                   [app endBackgroundTask:backTaskId];
                               }
                           }];
                       }
                   });
}

//网络不好的情况下，连续一段时间收到这种错误，可以提醒应用层降低分辨率
- (void)onBadNetworking:(NSNotification*)notification
{
    NSLog(@"live streaming on bad networking");
}
//mediacapture实例资源释放
- (void)onSdkDealloc:(NSNotification*)notification
{
    NSLog(@"SDK dealloc");
}

//收到此消息，说明直播真的开始了
- (void)onStartLiveStream:(NSNotification*)notification
{
    NSLog(@"on start live stream");//只有收到直播开始的 信号，才可以关闭直播
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        [self.hub hide:YES];
        _isLiving = YES;
        [self.view makeToast:@"直播已开始" duration:2.0 position:CSToastPositionCenter];

    });
}
//直播结束的通知消息
- (void)onFinishedLiveStream:(NSNotification*)notification
{
    NSLog(@"on finished live stream");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:LS_LiveStreaming_Finished object:_mediaCapture];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:LS_LiveStreaming_Started object:_mediaCapture];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:LS_LiveStreaming_SDK_dealloc object:_mediaCapture];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:LS_LiveStreaming_Bad object:_mediaCapture];
}
#pragma  - mark - backButtonPressed

- (void)backButtonPressed:(id)sender
{
    //释放资源
    if (_isLiving && _mediaCapture) {
        __weak typeof(self) weakSelf = self;
        [_mediaCapture stopLiveStream:^(NSError *error) {
            if(error == nil)
            {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    _isLiving = NO;
                    UIImage *startBtnImage = [UIImage imageNamed:@"restart"];
                    [weakSelf.pauseBtn setBackgroundImage:startBtnImage  forState:UIControlStateNormal];
                    [weakSelf dismissViewControllerAnimated:NO completion:nil];
                });
            }
        }];
    }
    else{
       [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)buttonTouchedHighlight:(id)sender
{
    UIButton *touchedButton = (UIButton *)sender;
    [touchedButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
}


- (void)switchButtonPressed:(id)sender
{
  
    [_mediaCapture switchCamera];
    [self.switchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
//显示错误消息
- (void)showErrorInfo:(NSError*)error
{
    NSString *errMsg = [error localizedDescription];
    self.errorInfoView.message = errMsg;
    
    [self.errorInfoView show];
    self.pauseBtn.enabled = YES;
    
    UIImage *startBtnImage = [UIImage imageNamed:@"restart"];
    [self.pauseBtn setBackgroundImage:startBtnImage  forState:UIControlStateNormal];
}

- (void)showhub{
    self.hub = [[MBProgressHUD alloc] initWithView:self.pauseBtn];
    [self.view addSubview:self.hub];
    
    self.hub.opaque = 0.7;
    self.hub.color = [UIColor blackColor];
    self.hub.labelText = @"加载中";
    [self.hub show:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(3.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.hub hide:YES];
    });
}

- (void)startPushLiveStream{
    
    if(!_isLiving)
    {
        //直播开始之前，需要设置直播出错反馈回调，当然也可以不设置
        __weak NEMediaCaptureViewController *weakSelf = self;
        _mediaCapture.onLiveStreamError = ^(NSError* error)
        {
            if (error != nil) {
                [weakSelf LiveStreamErrorInterrup];
                dispatch_async(dispatch_get_main_queue(), ^(void){[weakSelf showErrorInfo:error];});
            }
        };
        //开始直播
        NSError* error = nil;
        
        //添加水印
        CGRect rect = CGRectMake(10, 26,125,23);
        [_mediaCapture addWaterMark:[UIImage imageNamed:@"NELogo"] rect:rect location:LS_WATERMARK_LOCATION_RIGHTUP];
        [_mediaCapture startLiveStreamWithError:&error];
        if (error) {
            [self showErrorInfo:error ];
            return;
        }
        //设置获取当前播放位置回调
        _isLiving = YES;
        
        return;
    }
}


- (void)startButtonPressed:(id)sender
{
    if(!_isLiving)
    {
        [self startPushLiveStream];
        [self.pauseBtn setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
        [self showhub];
        [self.view makeToast:@"直播已开始" duration:2.0 position:CSToastPositionCenter];
    }
    else{
        __weak NEMediaCaptureViewController *weakSelf = self;
        [_mediaCapture stopLiveStream:^(NSError *error) {
            if (error == nil) {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    _isLiving = NO;
                    [weakSelf.pauseBtn setBackgroundImage:[UIImage imageNamed:@"restart"] forState:UIControlStateNormal];
                    //设置提示
                    [self.view makeToast:@"直播已停止" duration:2.0 position:CSToastPositionCenter];
                });
            }
        }];
    }
}

- (void)musicButtonPressed:(id)sender
{
    self.audioWrapView.hidden = NO;
}


- (void)LiveStreamErrorInterrup{
    __weak typeof(self) weakSelf = self;
    [_mediaCapture stopLiveStream:^(NSError *error) {
    
        if (error == nil) {
            NSLog(@"直播结束了");
            weakSelf.isLiving = NO;
        }
        else{
            NSLog(@"结束直播发生错误");
        }
    }];
}


//应用程序需要事先申请音视频使用权限
- (BOOL)requestMediaCapturerAccessWithCompletionHandler:(void (^)(BOOL, NSError*))handler {
    AVAuthorizationStatus videoAuthorStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    AVAuthorizationStatus audioAuthorStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    if (AVAuthorizationStatusAuthorized == videoAuthorStatus && AVAuthorizationStatusAuthorized == audioAuthorStatus) {
        handler(YES,nil);
    }else{
        if (AVAuthorizationStatusRestricted == videoAuthorStatus || AVAuthorizationStatusDenied == videoAuthorStatus) {
            NSString *errMsg = NSLocalizedString(@"此应用需要访问摄像头，请设置", @"此应用需要访问摄像头，请设置");
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
            NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
            handler(NO,error);
            
            return NO;
        }
        if (AVAuthorizationStatusRestricted == audioAuthorStatus || AVAuthorizationStatusDenied == audioAuthorStatus) {
            NSString *errMsg = NSLocalizedString(@"此应用需要访问麦克风，请设置", @"此应用需要访问麦克风，请设置");
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
            NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
            handler(NO,error);
            return NO;
        }
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                    if (granted) {
                        handler(YES,nil);
                    }else{
                        NSString *errMsg = NSLocalizedString(@"不允许访问麦克风", @"不允许访问麦克风");
                        NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
                        NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
                        handler(NO,error);
                    }
                }];
            }else{
                NSString *errMsg = NSLocalizedString(@"不允许访问摄像头", @"不允许访问摄像头");
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
                NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
                handler(NO,error);
            }
        }];
        
    }
    return YES;
}
@end
