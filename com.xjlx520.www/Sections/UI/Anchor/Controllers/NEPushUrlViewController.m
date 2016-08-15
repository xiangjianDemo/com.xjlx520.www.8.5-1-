//
//  InputUrlViewController.m
//  LSMediaCaptureDemo
//
//  Created by NetEase on 5/9/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import "NEPushUrlViewController.h"
#import "NEStartLiveStreamViewController.h"
#import "LSMediaCapture.h"

@interface NEPushUrlViewController ()

@property (nonatomic,strong) UIImageView   *bgImageView;
@property (nonatomic,strong) UITextField *urlPathTextField;//地址栏
@property (nonatomic,strong) UIButton *joinLiveStreamBtn;//直播按钮
@property (nonatomic,strong) UIView *StatusBar;
@property (nonatomic,strong) UIView *navBar;
@property (nonatomic,strong) UIView *line;

@end
@implementation NEPushUrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    self.bgImageView.frame = self.view.bounds;
    self.bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.bgImageView];

    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self setUpNavBarView];//设置导航栏
    [self setUpCenterPart];//设置其他控件
}

-(void)setUpNavBarView{
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"host_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0,26, 23, 23);
    [backBtn addTarget:self action:@selector(getBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * btnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-10;
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,btnItem]];
    
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont:[UIFont systemFontOfSize:19],UITextAttributeTextColor:[UIColor whiteColor]};
    self.navigationItem.title = @"主播";
}

-(void)getBack{
    if (self) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)setUpCenterPart{
    //直播地址
    self.urlPathTextField = [[UITextField alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame), UIScreenWidth,45)];
    self.urlPathTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 10, 0)];
    self.urlPathTextField.leftViewMode = UITextFieldViewModeAlways;
    self.urlPathTextField.textColor = [[UIColor alloc] initWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.3];
    self.urlPathTextField.font = [UIFont systemFontOfSize:16];
    self.urlPathTextField.borderStyle = UITextBorderStyleNone;
    self.urlPathTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.urlPathTextField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.urlPathTextField addTarget:self action:@selector(textFiledDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.urlPathTextField.tintColor = [UIColor whiteColor];
    self.urlPathTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString: @"请输入直播流地址" attributes:@{UITextAttributeTextColor:[[UIColor alloc] initWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2]}];
    
    //line
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.urlPathTextField.frame), UIScreenWidth, 1)];
    self.line.backgroundColor = [[UIColor alloc] initWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2];
    
    //进入直播
    CGFloat joinLiveStreamBtnW = 230;
    CGFloat joinLiveStreamBtnH = 40;
    CGFloat joinLiveStreamBtnX = UIScreenWidth/2.0 - joinLiveStreamBtnW/2.0;
    CGFloat joinLiveStreamBtnY = 150;

    
    self.joinLiveStreamBtn = [[UIButton alloc] initWithFrame:CGRectMake(joinLiveStreamBtnX, joinLiveStreamBtnY, joinLiveStreamBtnW, joinLiveStreamBtnH)];
    [self.joinLiveStreamBtn setTitle:@"进入直播" forState:UIControlStateNormal];
    [self.joinLiveStreamBtn setTitleColor:UIColorFromRGB(0x797976) forState:UIControlStateDisabled];
    UIImage *image = [[UIImage imageNamed:@"enter_live_still_C"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) resizingMode:UIImageResizingModeStretch];
    
    [self.joinLiveStreamBtn setBackgroundImage:image forState:UIControlStateNormal];
    self.joinLiveStreamBtn.enabled = self.urlPathTextField.text.length;
    [self.joinLiveStreamBtn addTarget:self action:@selector(joinButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.urlPathTextField];
    [self.view addSubview:self.line];
    [self.view addSubview:self.joinLiveStreamBtn];
    
}


- (void)joinButtonPressed:(id)sender {
    
    NSURL *url = NULL; //待播放的文件路径
    UIAlertView *alert = NULL; //定义一个消息提示框
    url = [[NSURL alloc] initWithString:self.urlPathTextField.text];
    if([self.urlPathTextField.text length]==0){
        alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入直播流地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
        
    }
   
    NEStartLiveStreamViewController *startLive = [[NEStartLiveStreamViewController alloc] initWithNibName:nil bundle:nil];
    startLive.pushUrl = self.urlPathTextField.text;
    [self presentViewController:startLive animated:YES completion:nil];
}

#pragma mark - textField method
- (void)textFieldDone:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (void)textFiledDidChange:(UITextField *)textField {
    if ([self.urlPathTextField.text length]==0) {
        self.joinLiveStreamBtn.enabled = NO;
        
        UIImage *orginImg = [UIImage imageNamed:@"enter_live_still_C"];
        UIImage *stretchImg1=[orginImg stretchableImageWithLeftCapWidth:orginImg.size.width*0.5 topCapHeight:orginImg.size.height*0.5];
        [self.joinLiveStreamBtn setBackgroundImage:stretchImg1 forState:UIControlStateNormal];
        
    }else{
        self.joinLiveStreamBtn.enabled = YES;
        UIImage *orginImg = [UIImage imageNamed:@"enter_live_alive"];
        UIImage *stretchImg2 = [orginImg stretchableImageWithLeftCapWidth:orginImg.size.width*0.5 topCapHeight:orginImg.size.height*0.5];
        [self.joinLiveStreamBtn setBackgroundImage:stretchImg2 forState:UIControlStateNormal];
        
    }
}


@end
