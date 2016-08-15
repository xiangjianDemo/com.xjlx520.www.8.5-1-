//
//  enterViewController.m
//  LSMediaCaptureDemo
//
//  Created by NetEase on 4/28/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import "NEEnterViewController.h"
#import "NEPushUrlViewController.h"
#import "NEPullUrlViewController.h"
#import "NTESGlobalMacro.h"

@interface NEEnterViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong) UIImageView   *bgImageView;
@property (nonatomic,strong) UILabel       *tipLable;
@property (nonatomic,strong) UIButton      *hostEnterBtn;
@property (nonatomic,strong) UIButton      *audienceEnterBtn;
@end

@implementation NEEnterViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubviews];
}

-(void)setUpSubviews{
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    self.bgImageView.frame = self.view.bounds;
    self.bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.bgImageView];
    
    //创建设置tipLabel
    [self.view addSubview:self.tipLable];
    
    //主播进入按钮
    [self.hostEnterBtn addTarget:self action:@selector(hostEnter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.hostEnterBtn];
    
    //观众进入按钮
    [self.audienceEnterBtn addTarget:self action:@selector(audienceEnter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.audienceEnterBtn];

}

-(void)hostEnter{
    NEPushUrlViewController *push=[[NEPushUrlViewController alloc] init];
    [self.navigationController pushViewController:push animated:YES];
}

-(void)audienceEnter{
    NEPullUrlViewController *audience=[[NEPullUrlViewController alloc] init];
    [self.navigationController pushViewController:audience animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=NO;
}

#pragma mark - Setter
- (UILabel *)tipLable
{
    if (!_tipLable) {
        CGFloat tipLblW = 148.f * UISreenWidthScale;
        CGFloat tipLblH = 60.f * UISreenWidthScale;
        CGFloat tipLblX = (UIScreenWidth/2.0 - tipLblW/2.0);
        CGFloat tipLblY = 185 * UISreenWidthScale;
        _tipLable = [[UILabel alloc] initWithFrame:CGRectMake(tipLblX, tipLblY, tipLblW, tipLblH)];
        [_tipLable setText:@"请选择您的身份"];
        [_tipLable setTextAlignment:NSTextAlignmentCenter];
        [_tipLable setFont:[UIFont systemFontOfSize:20]];
        [_tipLable setTextColor:[UIColor whiteColor]];
    }
    return _tipLable;
}

- (UIButton *)audienceEnterBtn
{
    if (!_audienceEnterBtn) {
        CGFloat audienceEnterBtnW = 90.0f * UISreenWidthScale;
        CGFloat audienceEnterBtnH = 90.f * UISreenWidthScale;
        CGFloat audienceEnterBtnX = UIScreenWidth/2.0 + 29 * UISreenWidthScale;
        CGFloat audienceEnterBtnY = 256 * UISreenWidthScale;
        
        _audienceEnterBtn = [[UIButton alloc] initWithFrame:CGRectMake(audienceEnterBtnX, audienceEnterBtnY, audienceEnterBtnW, audienceEnterBtnH)];
        [_audienceEnterBtn setBackgroundImage:[UIImage imageNamed:@"hostImg"]forState:UIControlStateNormal];
        [_audienceEnterBtn setBackgroundImage:[UIImage imageNamed:@"host_check"] forState:UIControlStateHighlighted];
        
        [_audienceEnterBtn setTitle:@"观众" forState:UIControlStateNormal];
        [_audienceEnterBtn setTitle:@"" forState:UIControlStateHighlighted];
        [_audienceEnterBtn setTitleColor:[UIColor colorWithRed:0.84 green:0.69 blue:0.39 alpha:1.00] forState:UIControlStateNormal];
    }
    return _audienceEnterBtn;
}

- (UIButton *)hostEnterBtn
{
    if (!_hostEnterBtn) {
        CGFloat hostEnterBtnW = 90.0f * UISreenWidthScale;
        CGFloat hostEnterBtnH = 90.f * UISreenWidthScale;
        CGFloat hostEnterBtnX = UIScreenWidth/2.0 - 29 * UISreenWidthScale-hostEnterBtnW;
        CGFloat hostEnterBtnY = 256 * UISreenWidthScale;
        
        _hostEnterBtn = [[UIButton alloc] initWithFrame:CGRectMake(hostEnterBtnX, hostEnterBtnY, hostEnterBtnW, hostEnterBtnH)];
        [_hostEnterBtn setBackgroundImage:[UIImage imageNamed:@"hostImg"]forState:UIControlStateNormal];
        [_hostEnterBtn setBackgroundImage:[UIImage imageNamed:@"host_check"] forState:UIControlStateHighlighted];
        [_hostEnterBtn setTitle:@"主播" forState:UIControlStateNormal];
        [_hostEnterBtn setTitle:@"" forState:UIControlStateHighlighted];
        [_hostEnterBtn setTitleColor:[UIColor colorWithRed:0.84 green:0.69 blue:0.39 alpha:1.00] forState:UIControlStateNormal];
    }
    return _hostEnterBtn;
}
@end
