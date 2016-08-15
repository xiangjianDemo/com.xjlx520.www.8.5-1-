//
//  NELivePlayerLoginViewController.m
//  NELivePlayerDemo
//
//  Created by NetEase on 15-10-10.
//  Copyright (c) 2015年 netease. All rights reserved.
//

#import "NEPullUrlViewController.h"
#import "NELivePlayerViewController.h"
#import "UIView+Toast.h"
#import "NTESGlobalMacro.h"

@interface NEPullUrlViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIImageView   *bgImageView;
@property (nonatomic, copy)  NSString *status; //保存网络状态
@property (nonatomic,strong) UIView *StatusBar;
@property (nonatomic,strong) UIView *navBar;//导航栏
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UILabel *addressLbL;
@property (nonatomic,strong) UITextField *urlPathTextField;//网络流地址输入框

@property (nonatomic,strong)  UILabel *pullDirlbl;
@property (nonatomic,strong) UISegmentedControl *media_type;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *playerBtn;//播放按钮
@property (nonatomic,strong) UIView *line;


@end

@implementation NEPullUrlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    self.bgImageView.frame = self.view.bounds;
    self.bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.bgImageView];

    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self setUpNavBar];
    [self setUpCenterPart];
}

- (void)setUpNavBar{
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"host_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0,26, 23, 23);
    [backBtn addTarget:self action:@selector(getBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * btnItem=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-10;
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,btnItem]];

    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont:[UIFont systemFontOfSize:19],UITextAttributeTextColor:[UIColor whiteColor]};
    self.navigationItem.title = @"观众";
}

//设置其他控件
- (void)setUpCenterPart{
    //直播地址
    self.urlPathTextField = [[UITextField alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame), UIScreenWidth,45)];
    self.urlPathTextField.leftView     = [[UIView alloc] initWithFrame:CGRectMake(0,0, 10, 0)];
    self.urlPathTextField.leftViewMode = UITextFieldViewModeAlways;

    self.urlPathTextField.textColor    = [[UIColor alloc] initWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.3];
    self.urlPathTextField.font         = [UIFont systemFontOfSize:16];
    self.urlPathTextField.borderStyle  = UITextBorderStyleNone;
    self.urlPathTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.urlPathTextField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.urlPathTextField addTarget:self action:@selector(textFiledDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.urlPathTextField.tintColor = [UIColor whiteColor];
    self.urlPathTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString: @"请输入拉流地址" attributes:@{UITextAttributeTextColor:[[UIColor alloc] initWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2]}];
    //line
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.urlPathTextField.frame), UIScreenWidth, 1)];
    self.line.backgroundColor = [[UIColor alloc] initWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2];
    
    //进入直播
    CGFloat playerBtnW = 230;
    CGFloat playerBtnH = 40;
    CGFloat playerBtnX = UIScreenWidth/2.0 - playerBtnW/2.0;
    CGFloat playerBtnY = 150;
    
    
    self.playerBtn = [[UIButton alloc] initWithFrame:CGRectMake(playerBtnX, playerBtnY, playerBtnW, playerBtnH)];
    [self.playerBtn setTitle:@"播放" forState:UIControlStateNormal];
    [self.playerBtn setTitleColor:UIColorFromRGB(0x797976) forState:UIControlStateDisabled];

    UIImage *orginImg = [UIImage imageNamed:@"enter_live_still_C"];
    UIImage *stretchImg = [orginImg stretchableImageWithLeftCapWidth:orginImg.size.width*0.5 topCapHeight:orginImg.size.height*0.5];
    [self.playerBtn setBackgroundImage:stretchImg forState:UIControlStateNormal];
    
    self.playerBtn.enabled = self.urlPathTextField.text.length;
    [self.playerBtn setTintColor:[[UIColor alloc] initWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2]];
    
    [self.playerBtn addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.urlPathTextField];
    [self.view addSubview:self.line];
    [self.view addSubview:self.playerBtn];

}


- (void)playButtonPressed:(id)sender {

    NSURL *url = [[NSURL alloc] initWithString:self.urlPathTextField.text];
    if([self.urlPathTextField.text length]==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入直播流地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }

    NSMutableArray *decodeParm = [[NSMutableArray alloc] init];
    [decodeParm addObject:@"software"];
    [decodeParm addObject:@"livestream"];

    NELivePlayerViewController *livePlayerVC = [[NELivePlayerViewController alloc] initWithURL:url andDecodeParm:decodeParm];
    livePlayerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:livePlayerVC animated:YES completion:nil];

}

#pragma mark - textField method
- (void)textFieldDone:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (void)textFiledDidChange:(UITextField *)textField {
    if ([self.urlPathTextField.text length] == 0) {
        self.playerBtn.enabled = NO;
        
        UIImage *orginImg = [UIImage imageNamed:@"enter_live_still_C"];
        UIImage *stretchImg1 = [orginImg stretchableImageWithLeftCapWidth:orginImg.size.width*0.5 topCapHeight:orginImg.size.height*0.5];
        [self.playerBtn setBackgroundImage:stretchImg1 forState:UIControlStateNormal];
    }else{
        self.playerBtn.enabled = YES;
        UIImage *orginImg = [UIImage imageNamed:@"enter_live_alive"];
        UIImage *stretchImg2 = [orginImg stretchableImageWithLeftCapWidth:orginImg.size.width*0.5 topCapHeight:orginImg.size.height*0.5];
        [self.playerBtn setBackgroundImage:stretchImg2 forState:UIControlStateNormal];
        
    }
}

- (void)getBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
